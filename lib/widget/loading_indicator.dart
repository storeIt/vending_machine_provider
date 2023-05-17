import 'package:flutter/material.dart';

class LoadingIndicator {
  OverlayEntry? _overlay;
  final BuildContext context;

  LoadingIndicator(this.context);

  void showLoading() {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (_) => const ColoredBox(
          color: Color(0x80000000),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  void hideLoading() {
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}
