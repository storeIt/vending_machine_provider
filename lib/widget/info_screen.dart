import 'package:flutter/material.dart';

import '../constant/material/dimen.dart';

class InfoScreen extends StatelessWidget {
  final String message;
  final String? withAction;
  final Function? onAction;

  const InfoScreen({required this.message, this.withAction, this.onAction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: defaultPadding),
        if (withAction != null)
          TextButton(
            onPressed: onAction != null ? () => onAction!() : null,
            child: Text(withAction!),
          ),
      ],
    )));
  }
}
