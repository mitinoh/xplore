import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton(
      {Key? key, required this.text, required this.colors, required this.colorsText})
      : super(key: key);
  final String text;
  final Color colors;
  final Color colorsText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colors,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text.toString().toUpperCase(),
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: colorsText),
          ),
        ],
      ),
    );
  }
}
