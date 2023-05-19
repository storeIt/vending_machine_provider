import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/view_model/base_view_model.dart';
import '../../../constant/app_constant.dart';
import '../../../constant/material/dimen.dart';
import '../../../util/service/service_locator.dart';
import '../../../util/service/view/state_event_service.dart';
import '../../products/model/product.dart';
import '../view_model/vending_view_model.dart';

class VendingPage extends StatefulWidget {
  static const String routeName = '/vending';
  final Product product;

  const VendingPage({required this.product, Key? key}) : super(key: key);

  @override
  State<VendingPage> createState() => _VendingPageState();
}

class _VendingPageState extends StateEventService<VendingPage> {
  final TextEditingController controller = TextEditingController();
  final VendingViewModel _viewModel = locator<VendingViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.init(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _viewModel.shouldNavigateBack();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _viewModel.shouldNavigateBack() ? Navigator.of(context).pop() : null;
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf0ead2),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
                            child: Text(
                              widget.product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${AppConstant.currencySymbol} ${widget.product.price}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        autofocus: true,
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: AppConstant.insertCoin,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(borderRadiusSmall),
                            ),
                          ),
                        ),
                        // autofocus: true,
                        onChanged: (String value) {
                          if (AppConstant.validInputRegex.hasMatch(value)) {
                            _viewModel.manageInput(value);
                            controller.clear();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          _viewModel.reset();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadiusSmall),
                            ),
                          ),
                        ),
                        child: const Text(AppConstant.reset),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(borderRadiusSmall),
                    ),
                    child: ChangeNotifierProvider<VendingViewModel>(
                      create: (context) => _viewModel,
                      child: Consumer<VendingViewModel>(
                        builder: (context, provider, _) {
                          return Text(
                            provider.displayText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  BaseViewModel getModel() {
    return _viewModel;
  }
}
