import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
                text: "Cliccando il bottone continua con gooole o apple accetti",
                style: GoogleFonts.poppins(
                    color: lightDark.primaryColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 9),
                children: <TextSpan>[
                  TextSpan(
                      text: " " + "i termi delle condizioni",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w300)),
                  TextSpan(
                      text: " " + "e" + " ",
                      style: TextStyle(
                        color: lightDark.primaryColor,
                      )),
                  TextSpan(
                      text: "la privacy" + ".",
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.w300))
                ]),
          ),
        ),
      ],
    );
  }
}
