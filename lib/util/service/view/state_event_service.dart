import 'package:flutter/material.dart';

import '../../../base/view_model/base_view_model.dart';
import '../../../widget/loading_indicator.dart';
import '../../helper/stream/stream_event.dart';
import '../../mixin/view_action.dart';

abstract class StateEventService<T extends StatefulWidget> extends State<T> with ViewAction {
  late final LoadingIndicator loadingIndicator;

  @override
  void initState() {
    super.initState();
    loadingIndicator = LoadingIndicator(context);

    getModel().subscriptions.add(getModel().stream.listen((stream) {
          switch (stream.type) {
            case StreamEvent.closeKeyboard:
              FocusScope.of(context).unfocus();
              break;
            case StreamEvent.error:
              showError(stream.data);
              break;
            case StreamEvent.pop:
              Navigator.of(context).pop(true);
              break;
            case StreamEvent.push:
              Navigator.of(context, rootNavigator: stream.get('root_navigator') == true)
                  .pushNamed(stream.get('page'), arguments: stream.get('arguments'));
              break;
            case StreamEvent.pushReplacementNamed:
              Navigator.pushReplacementNamed(
                context,
                stream.get('page'),
                arguments: stream.get('arguments'),
              );
              break;
            case StreamEvent.snackBar:
              showSnackBar(stream.data);
              break;
            case StreamEvent.loading:
              loadingIndicator.showLoading();
              break;
            case StreamEvent.retrieved:
              loadingIndicator.hideLoading();
              break;
          }
        }));
  }

  @override
  void dispose() {
    getModel().unsubscribe();
    super.dispose();
  }

  BaseViewModel getModel();
}
