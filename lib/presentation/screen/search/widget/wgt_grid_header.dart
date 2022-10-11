import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridHeaderWidget extends StatelessWidget {
  GridHeaderWidget({Key? key}) : super(key: key);
  late ThemeData themex;
  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return Visibility(
      visible: true,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 15),
            child: Text(
              "Some inspirations...",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: themex.indicatorColor),
            ),
          ),
        ],
      ),
    );
  }
}
