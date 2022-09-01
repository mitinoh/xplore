import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key? key, this.state = null, this.message = ""}) : super(key: key);
  final state;
  final message;

  @override
  Widget build(BuildContext context) {
    return Text("Che vergogna");
  }
}
