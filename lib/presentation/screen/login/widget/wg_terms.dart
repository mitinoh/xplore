import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themex = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
                text: "Cliccando il bottone continua con gooole o apple accetti",
                style: GoogleFonts.poppins(
                    color: themex.primaryColor, fontWeight: FontWeight.w300, fontSize: 9),
                children: <TextSpan>[
                  TextSpan(
                      text: " i termi delle condizioni",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w300)),
                  TextSpan(
                      text: " e",
                      style: TextStyle(
                        color: themex.primaryColor,
                      )),
                  TextSpan(
                      text: " la privacy.",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w300))
                ]),
          ),
        ),
      ],
    );
  }
}
