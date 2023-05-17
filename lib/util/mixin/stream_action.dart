import 'dart:async';

import '../helper/stream/stream_data.dart';

mixin StreamAction {
  final List<StreamSubscription> _subscriptions = [];
  final StreamController<StreamData> _streamController = StreamController();

  Stream<StreamData> get stream => _streamController.stream;
  List<StreamSubscription> get subscriptions => _subscriptions;

  void streamAction(StreamData stream) {
    _streamController.add(stream);
  }

  void unsubscribe() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _streamController.close();
  }
}
