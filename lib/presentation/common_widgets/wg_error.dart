import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key? key, this.state = null, this.message = "Ops..", this.errorDetails})
      : super(key: key);
  final state;
  final String? message;
  final FlutterErrorDetails? errorDetails;

  late ThemeData themex;
  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return Text(
      message.toString(),
      style: TextStyle(color: themex.indicatorColor),
    );
  }
}
