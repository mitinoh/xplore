import 'package:flutter/material.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class DetailMenuWidget extends StatelessWidget {
  const DetailMenuWidget(
      {Key? key, required this.expanded, required this.location, required this.toggle})
      : super(key: key);

  final bool expanded;
  final LocationModel location;
  final VoidCallback toggle;
  @override
  Widget build(BuildContext context) {
    final ThemeData lightDark = Theme.of(context);

    return Positioned(
        child: AnimatedContainer(
          height: expanded ? 340 : 82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: lightDark.scaffoldBackgroundColor.withOpacity(0.8)),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 24),
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          duration: const Duration(seconds: 1),
          curve: Curves.bounceOut,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: RichText(
                    textScaleFactor: 1,
                    text: TextSpan(
                        text: location.name,
                        style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: lightDark.primaryColor),
                        children: [
                          TextSpan(
                              text: ", " + location.desc.toString().toLowerCase(),
                              style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w300,
                                  color: lightDark.primaryColor)),
                          TextSpan(
                              text:
                                  "\n\nQui ci sarà la parte dei consigli su come raggiungere il luogo e altri piccoli consigli.",
                              style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w300,
                                  color: lightDark.primaryColor)),
                          TextSpan(
                              text: "\n\n#mare #italy #ladolcevita #estate",
                              style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w400,
                                  color: lightDark.primaryColor)),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: InkWell(
                  onTap: () => {toggle()},
                  child: expanded
                      ? Icon(Icons.close, color: lightDark.primaryColor)
                      : Icon(Iconsax.maximize_4, color: lightDark.primaryColor),
                ),
              )
            ],
          ),
        ),
        bottom: 0,
        right: 0,
        left: 0);
  }
}
