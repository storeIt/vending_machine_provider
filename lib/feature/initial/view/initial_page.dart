import 'package:flutter/material.dart';

import '../../../util/service/service_locator.dart';
import '../../../util/service/view/state_event_service.dart';
import '../view_model/initial_view_model.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends StateEventService<InitialPage> {
  final InitialViewModel _viewModel = locator<InitialViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  getModel() => _viewModel;
}
