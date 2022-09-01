import 'package:flutter/material.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        _headerTitle(),
        const SizedBox(height: 20),
        _headerDesc(),
        const SizedBox(height: 20),
      ],
    );
  }

  Row _headerDesc() {
    return Row(
      children: [
        Expanded(
          child: Text(
              "Contribuisci a rendere xplore un posto vibrante. Raccomanda un nuovo posto e ricevi 200 punti.",
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
        )
      ],
    );
  }

  Row _headerTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [HeaderName(message: "Vuoi suggerirci un posto ", questionMark: true)],
    );
  }
}
