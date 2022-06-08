import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/core/UIColors.dart';

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({Key? key}) : super(key: key);

  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: UIColors.azure,
        content: Text(message,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
