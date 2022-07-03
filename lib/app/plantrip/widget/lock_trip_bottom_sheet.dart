import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class LockTripBottomSheet extends StatelessWidget {
  const LockTripBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    return Container(
      height: mediaQuery.size.height * 0.45,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: lightDark.backgroundColor,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 70,
                backgroundColor: UIColors.lightPurple,
                child: const Icon(
                  Iconsax.lock,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "vacanza non pronta",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: lightDark.primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                child: Text(
                  "Questa vacanza è stata programmata, sarà disponibile quando è in corso",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: lightDark.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
