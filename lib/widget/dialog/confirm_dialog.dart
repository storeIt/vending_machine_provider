import 'package:flutter/material.dart';

import '../../constant/app_constant.dart';
import '../../constant/material/dimen.dart';

class ConfirmDialog extends StatelessWidget {
  final String message;

  const ConfirmDialog(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const SizedBox(height: spacingVerticalMedium),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: spacingVerticalMedium),
          const Divider(
            height: 1,
            color: Colors.cyan,
            thickness: 1,
            indent: spacingHorizontalLarge,
            endIndent: spacingHorizontalLarge,
          ),
          const SizedBox(height: spacingVerticalMedium),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(AppConstant.confirm),
          )
        ]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ));
  }
}
