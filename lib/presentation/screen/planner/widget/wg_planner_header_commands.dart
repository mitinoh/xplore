import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/app.dart';

class PlannerHeaderCommandWidget extends StatelessWidget {
  PlannerHeaderCommandWidget({
    Key? key,
    required this.onQuestionChange,
  }) : super(key: key);

  final VoidCallback onQuestionChange;
  final ThemeData themex = App.themex;

  @override
  Widget build(BuildContext context) {
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
                  color: themex.primaryColor,
                )),
            RichText(
              text: TextSpan(
                text: 'Creazione vacanza',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: themex.primaryColor),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: themex.primaryColor,
                )),
          ],
        ),
      ],
    );
  }
}
