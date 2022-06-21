import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:xplore/app/add_location/screen/new_location_screen.dart';
import 'package:xplore/app/auth/widgets/header_onboarding.dart';
import 'package:xplore/core/widgets/confirm_button.dart';

class BeforeAddingNewLocation extends StatelessWidget {
  const BeforeAddingNewLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            children: [
              const HeaderOnboarding(),
              const SizedBox(height: 40),
              Text("Condividi la tua esperianza",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
              const SizedBox(height: 10),
              Text(
                  "Hai visto un posto che ti piace? Mostra un posto memorabile, interessante o fantastico.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewLocation()),
                    );
                  },
                  child: const ConfirmButton(text: "Condivida ora"))
            ],
          ),
        ),
      ),
    );
  }
}
