import '../helper/stream/stream_data.dart';
import '../helper/stream/stream_event.dart';
import 'stream_action.dart';

mixin VendingAction on StreamAction {
  void closeKeyboard() {
    streamAction(StreamData(StreamEvent.closeKeyboard, null));
  }

  void pop([Object? arguments]) {
    streamAction(StreamData(StreamEvent.pop, arguments));
  }

  void pushReplacementNamed(String routeName, [Object? arguments]) {
    streamAction(StreamData(StreamEvent.pushReplacementNamed, {'page': routeName, 'arguments': arguments}));
  }

  void showSnackBar(String message) {
    streamAction(StreamData(StreamEvent.snackBar, message));
  }
}
