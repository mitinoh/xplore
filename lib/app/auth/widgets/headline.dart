import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadLine extends StatelessWidget {
  const HeadLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                  text: 'welcome on',
                  style: GoogleFonts.poppins(
                      color: lightDark.primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                      text: " Xplore",
                      style: GoogleFonts.poppins(
                          color: lightDark.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )
                  ]),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                  "Immergiti in un esperienza unica e scopri il mondo intorno a te e i tuoi amici!",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey)),
            )
          ],
        ),
      ],
    );
  }
}
