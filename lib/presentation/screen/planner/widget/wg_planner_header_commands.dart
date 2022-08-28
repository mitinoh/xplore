import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class PlannerHeaderCommandWidget extends StatelessWidget {
  const PlannerHeaderCommandWidget({
    Key? key,
    required this.onQuestionChange,
  }) : super(key: key);
  final VoidCallback onQuestionChange;
  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  onQuestionChange();
                },
                child: Icon(
                  Iconsax.arrow_left,
                  color: lightDark.primaryColor,
                )),
            RichText(
              text: TextSpan(
                text: 'Creazione vacanza',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: lightDark.primaryColor),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: lightDark.primaryColor,
                )),
          ],
        ),
      ],
    );
  }
}
