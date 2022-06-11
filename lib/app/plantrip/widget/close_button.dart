import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

class BackButtonUI extends StatelessWidget {
  const BackButtonUI({
    Key? key,
    required this.onCountSelected,
  }) : super(key: key);
  final VoidCallback onCountSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              onCountSelected();
            },
            child: const Icon(Iconsax.arrow_left)),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text("scarta",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: UIColors.lightRed)),
        )
      ],
    );
  }
}
