import '../helper/stream/stream_data.dart';
import '../helper/stream/stream_event.dart';
import 'stream_action.dart';

mixin VendingAction on StreamAction {
  void showLoading() {
    streamAction(StreamData(StreamEvent.loading, null));
  }

  void hideLoading() {
    streamAction(StreamData(StreamEvent.retrieved, null));
  }

  void requireCategoryUpdate() {
    streamAction(StreamData(StreamEvent.updateCategories, null));
  }

  void closeKeyboard() {
    streamAction(StreamData(StreamEvent.closeKeyboard, null));
  }

  void pop([Object? arguments]) {
    streamAction(StreamData(StreamEvent.pop, arguments));
  }

  void requireProductsUpdate() {
    streamAction(StreamData(StreamEvent.updateProducts, null));
  }

  void showSnackBar(String message) {
    streamAction(StreamData(StreamEvent.snackBar, message));
  }
}
