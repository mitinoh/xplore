import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                InkWell(
                    onTap: () => {Navigator.pop(context)},
                    child: const Icon(Iconsax.arrow_left)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nome delle vacanza",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        VerticalDivider(
                          color: UIColors.blue,
                          thickness: 4,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'lorem ipsum is simply dummy text of the printing and typesetting industry.',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' dettaglio luogo',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text("22 giugno",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        VerticalDivider(
                          color: UIColors.blue,
                          thickness: 4,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'lorem ipsum is simply dummy text of the printing and typesetting industry.',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' dettaglio luogo',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text("23 giugno",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        VerticalDivider(
                          color: UIColors.blue,
                          thickness: 4,
                        ),
                        //StepCircle(indice: menu.steps.indexOf(item) + 1),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'lorem ipsum is simply dummy text of the printing and typesetting industry.',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' dettaglio luogo',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text("24 giugno",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        VerticalDivider(
                          color: UIColors.blue,
                          thickness: 4,
                        ),
                        //StepCircle(indice: menu.steps.indexOf(item) + 1),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'lorem ipsum is simply dummy text of the printing and typesetting industry.',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' dettaglio luogo',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text("25 giugno",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
