import 'package:flutter/material.dart';

class CloseButtonUI extends StatelessWidget {
  const CloseButtonUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close));
  }
}
