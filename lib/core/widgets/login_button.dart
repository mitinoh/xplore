import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.text, required this.colors})
      : super(key: key);
  final String text;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'continua con ',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: text,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )
                      ]),
                )),
          )
        ],
      ),
    );
  }
}
