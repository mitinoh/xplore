import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/core/UIColors.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: UIColors.lightGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text.toString().toUpperCase(),
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
