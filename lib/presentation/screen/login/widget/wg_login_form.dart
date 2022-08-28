import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/login/widget/wg_buttton_google.dart';

class WidgetLoginForm extends StatefulWidget {
  const WidgetLoginForm({Key? key}) : super(key: key);

  @override
  State<WidgetLoginForm> createState() => _WidgetLoginFormState();
}

class _WidgetLoginFormState extends State<WidgetLoginForm> {
  @override
  Widget build(BuildContext context) {
    return _buildSocialLogin();
  }

  _buildSocialLogin() {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          _googleButton(),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  _googleButton() {
    return GoogleButton();
  }
}
