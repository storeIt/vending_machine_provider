import '../../../base/view_model/base_view_model.dart';
import '../../../constant/app_constant.dart';
import '../../../util/helper/event_bus_event/update_products.dart';
import '../../products/model/product.dart';

enum VendingPaymentState {
  initial,
  insufficient,
  sufficient,
  overpaid,
  invalidInput,
  reset,
}

class VendingViewModel extends BaseViewModel {
  late final Product _product;
  double _totalInput = 0;
  double _totalPrice = 0;
  String _displayText = '';

  String get displayText => _displayText;
  double get totalInput => _totalInput;

  void init(Product product) {
    _product = product;
    _totalPrice = product.price;
    _manageVending(VendingPaymentState.initial);
  }

  void manageInput(String input) {
    double amount = double.parse(input);
    _totalInput += amount;
    if (_totalInput < _totalPrice) {
      _manageVending(VendingPaymentState.insufficient);
    } else if (_totalInput == _totalPrice) {
      _manageVending(VendingPaymentState.sufficient);
    } else {
      _manageVending(VendingPaymentState.overpaid);
    }
  }

  bool shouldNavigateBack() {
    if (_totalInput > 0) {
      return false;
    }
    unsubscribe();
    return true;
  }

  void reset() async {
    _manageVending(VendingPaymentState.reset);
    closeKeyboard();
    await Future.delayed(const Duration(seconds: 5)).then((_) {
      _manageVending(VendingPaymentState.initial);
    });
  }

  void _manageVending(VendingPaymentState state) {
    switch (state) {
      case VendingPaymentState.initial:
        _setDisplayText(AppConstant.insertCoin);
        break;
      case VendingPaymentState.insufficient:
        _setDisplayText('Change: € ${_totalInput.toStringAsFixed(2)}');
        break;
      case VendingPaymentState.sufficient:
        _setDisplayText('Thank you and enjoy your ${_product.name}');
        _sale();
        break;
      case VendingPaymentState.overpaid:
        _setDisplayText(
            'Thank you :)\nEnjoy your ${_product.name} and take your change € ${(_totalInput - _totalPrice).toStringAsFixed(2)}');
        _sale();
        break;
      case VendingPaymentState.invalidInput:
        _setDisplayText('The inserted coin is not acceptable');
        break;
      case VendingPaymentState.reset:
        _setDisplayText('Take your change € $_totalInput');
        _totalInput = 0;
        break;
    }
  }

  void _sale() {
    _totalInput = 0;
    closeKeyboard();
    if (_product.quantity > 1) {
      _product.quantity--;
      repository.updateQuantity(_product);
    } else if (_product.quantity <= 1) {
      repository.deleteProduct(_product.id).then((value) {
        if (value == 1) {
          showSnackBar(_displayText);
          eventBus.fire(UpdateProducts());
          pop();
        }
      });
    }
  }

  void _setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }
}
