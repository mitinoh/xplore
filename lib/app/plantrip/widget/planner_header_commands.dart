import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/subtitle.dart';

class PlannerHeaderCommand extends StatelessWidget {
  const PlannerHeaderCommand({
    Key? key,
    required this.onCountSelected,
  }) : super(key: key);
  final VoidCallback onCountSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  onCountSelected();
                },
                child: const Icon(Iconsax.arrow_left)),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: 'Creazione vacanza',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            InkWell(
              onTap: (() => {Navigator.pop(context)}),
              child: CircleAvatar(
                backgroundColor: UIColors.lightRed,
                child: Icon(
                  Icons.cancel,
                  color: UIColors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 25),
        const Subtitle(
            text: "Settiamo insieme la tua prossima vacanza in pochi step.")
      ],
    );
  }
}
