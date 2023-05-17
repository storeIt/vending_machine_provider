import '../../../base/view_model/base_view_model.dart';
import '../../../constant/app_constant.dart';
import '../../products/model/product.dart';
import '../../products/repository/products_repository.dart';

enum VendingPaymentState {
  initial,
  insufficient,
  sufficient,
  overpaid,
  invalidInput,
  reset,
}

class VendingViewModel extends BaseViewModel {
  final ProductsRepository _repository = ProductsRepository();
  late final Product _product;
  double _totalInput = 0;
  double _totalPrice = 0;
  String _displayText = '';

  String get displayText => _displayText;
  double get totalInput => _totalInput;

  void init(Product product) {
    _product = product;
    _totalPrice = product.price;
    manageVending(VendingPaymentState.initial);
  }

  void manageInput(String input) {
    double amount = double.parse(input);
    _totalInput += amount;
    if (_totalInput < _totalPrice) {
      manageVending(VendingPaymentState.insufficient);
    } else if (_totalInput == _totalPrice) {
      manageVending(VendingPaymentState.sufficient);
    } else {
      manageVending(VendingPaymentState.overpaid);
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
    manageVending(VendingPaymentState.reset);
    closeKeyboard();
    await Future.delayed(const Duration(seconds: 5)).then((_) {
      manageVending(VendingPaymentState.initial);
    });
  }

  void manageVending(VendingPaymentState state) {
    switch (state) {
      case VendingPaymentState.initial:
        setDisplayText(AppConstant.insertCoin);
        break;
      case VendingPaymentState.insufficient:
        setDisplayText('Change: € ${_totalInput.toStringAsFixed(2)}');
        break;
      case VendingPaymentState.sufficient:
        setDisplayText('Thank you and enjoy your ${_product.name}');
        _onBuy();
        break;
      case VendingPaymentState.overpaid:
        setDisplayText(
            'Thank you :)\nEnjoy your ${_product.name} and take your change € ${(_totalInput - _totalPrice).toStringAsFixed(2)}');
        _onBuy();
        break;
      case VendingPaymentState.invalidInput:
        setDisplayText('The inserted coin is not acceptable');
        break;
      case VendingPaymentState.reset:
        setDisplayText('Take your change € $_totalInput');
        _totalInput = 0;
        break;
    }
  }

  void _onBuy() {
    _totalInput = 0;
    closeKeyboard();
    if (_product.quantity > 1) {
      _product.quantity--;
      _repository.updateQuantity(_product);
    } else if (_product.quantity <= 1) {
      _repository.deleteProduct(_product.id).then((value) {
        if (value == 1) {
          requireProductsUpdate();
          showSnackBar(_displayText);
          pop();
        }
      });
    }
  }

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }
}
