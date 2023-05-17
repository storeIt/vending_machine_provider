import 'package:flutter/material.dart';

import '../../widget/dialog/confirm_dialog.dart';

mixin ViewAction<T extends StatefulWidget> on State<T> {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showError(String message) {
    showDialog(context: context, builder: (_) => ConfirmDialog(message));
  }
}
