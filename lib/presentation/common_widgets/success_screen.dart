import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key, required this.title, required this.subtitle})
      : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.green,
                child: const Icon(
                  Iconsax.tick_square,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: lightDark.primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                child: Text(
                  subtitle.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: lightDark.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text("Tap ovunque per continuare".toUpperCase(),
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: lightDark.primaryColor)),
        ],
      ),
    );
  }
}
