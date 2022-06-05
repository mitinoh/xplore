import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key, required this.title, required this.subtitle})
      : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Yess success",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarGlow(
                glowColor: UIColors.lightGreen,
                endRadius: 62.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                child: CircleAvatar(
                  radius: 38,
                  backgroundColor: UIColors.lightGreen,
                  child: Icon(
                    Iconsax.cup,
                    color: UIColors.green,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(title.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(subtitle.toString(),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey)),
              )
            ],
          ),
          Text("Tap ovunque per continuare",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
        ],
      )),
    );
  }
}
