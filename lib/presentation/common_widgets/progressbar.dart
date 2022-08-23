import 'package:flutter/material.dart';
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.grey.withOpacity(0.3),
            minHeight: 2,
          ),
        ),
      ],
    );
  }
}
