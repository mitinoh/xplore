import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData lightDark = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.lightBlue,
          child: const Icon(
            Iconsax.coffee,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "No data found",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w500, color: lightDark.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
          child: Text(
            "Still no activity here.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 13, fontWeight: FontWeight.w300, color: lightDark.primaryColor),
          ),
        ),
      ],
    );
  }
}
