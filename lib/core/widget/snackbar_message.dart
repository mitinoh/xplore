import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({ Key? key }) : super(key: key);


  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}