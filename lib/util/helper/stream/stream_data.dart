import 'stream_event.dart';

class StreamData {
  final StreamEvent type;
  final dynamic data;

  StreamData(this.type, this.data);

  dynamic get(String arg) {
    return data[arg];
  }
}
