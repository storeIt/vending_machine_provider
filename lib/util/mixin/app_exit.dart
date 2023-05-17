import 'package:flutter/material.dart';

mixin AppExit {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || (now.difference(currentBackPressTime!) > const Duration(seconds: 2))) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }
}
