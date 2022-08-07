import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridHeaderWidget extends StatelessWidget {
  GridHeaderWidget({Key? key}) : super(key: key);
  late ThemeData _lightDark;
  @override
  Widget build(BuildContext context) {
    _lightDark = Theme.of(context);
    return Visibility(
      visible: true,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 15),
            child: Text(
              "Suggerimenti",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _lightDark.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
