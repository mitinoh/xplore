import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleTextWidget extends StatelessWidget {
  const CircleTextWidget({Key? key, required this.text}) : super(key: key);
  final dynamic text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(text.toString(),
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
    );
  }
}
