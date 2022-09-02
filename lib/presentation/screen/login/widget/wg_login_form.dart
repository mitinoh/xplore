import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/login/widget/wg_header_onboarding.dart';
import 'package:xplore/presentation/screen/login/widget/wg_headline.dart';
import 'package:xplore/presentation/screen/login/widget/wg_terms.dart';
import 'package:xplore/presentation/screen/login/widget/wg_buttton_google.dart';

class WidgetLoginForm extends StatefulWidget {
  const WidgetLoginForm({Key? key}) : super(key: key);

  @override
  State<WidgetLoginForm> createState() => _WidgetLoginFormState();
}

class _WidgetLoginFormState extends State<WidgetLoginForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildForm(),
        ),
      ),
    );
  }

  _buildForm() => <Widget>[
        _buildImageGrid(),
        const SizedBox(height: 20),
        _buildHeadLine(),
        const SizedBox(height: 20),
        _buildGoogleButton(),
        const SizedBox(height: 5),
        _buildAppleButton(),
        const SizedBox(height: 10),
        _buildTerms()
      ];
  _buildImageGrid() => const HeaderOnboarding();
  _buildHeadLine() => const HeadLineWidget();
  _buildGoogleButton() => const GoogleButton();
  _buildAppleButton() => const GoogleButton();
  _buildTerms() => TermsWidget();
}
