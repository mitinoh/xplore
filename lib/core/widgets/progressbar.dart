import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.valueProgressIndicator})
      : super(key: key);
  final double valueProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: valueProgressIndicator,
            valueColor: AlwaysStoppedAnimation<Color>(UIColors.mainColor),
            backgroundColor: UIColors.grey.withOpacity(0.3),
            minHeight: 2,
          ),
        ),
      ],
    );
  }
}
