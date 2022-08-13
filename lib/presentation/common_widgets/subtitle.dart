import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({Key? key, required this.text, required this.colors})
      : super(key: key);
  final String text;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(text.toString(),
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w300, color: colors)),
        )
      ],
    );
  }
}
