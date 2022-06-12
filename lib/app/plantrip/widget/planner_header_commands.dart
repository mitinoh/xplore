import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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
            RichText(
              text: TextSpan(
                text: 'Creazione vacanza',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close)),
          ],
        ),
      ],
    );
  }
}
