import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppleLogin extends StatelessWidget {
  const AppleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'continua con',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: " Apple",
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
