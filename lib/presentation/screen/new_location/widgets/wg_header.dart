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
        _headerDesc(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Row _headerDesc(BuildContext context) {
    ThemeData themex = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
              "Help make xplore a vibrant place. Help the community discover something new every day.",
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: themex.disabledColor)),
        )
      ],
    );
  }

  Row _headerTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [HeaderName(message: "Do you have a place to suggest us?", questionMark: true)],
    );
  }
}
