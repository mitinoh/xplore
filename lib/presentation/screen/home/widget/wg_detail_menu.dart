import 'package:flutter/material.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class DetailMenuWidget extends StatelessWidget {
  DetailMenuWidget({
    Key? key,
    this.expanded = false,
    required this.location,
    required this.toggleDetailMenu,
  }) : super(key: key);

  final bool expanded;
  final LocationModel location;
  final VoidCallback toggleDetailMenu;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: AnimatedContainer(
          height: expanded ? 340 : 82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: App.themex.scaffoldBackgroundColor.withOpacity(0.8)),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 24),
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          duration: const Duration(seconds: 1),
          curve: Curves.bounceOut,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_infoContainer(), _menuIcon()],
          ),
        ),
        bottom: 0,
        right: 0,
        left: 0);
  }

  Widget _infoContainer() {
    return Expanded(
      child: SingleChildScrollView(
        child: RichText(
          textScaleFactor: 1,
          text: _infoGroup(),
        ),
      ),
    );
  }

  TextSpan _infoGroup() {
    return TextSpan(
        text: location.name,
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: App.themex.primaryColor,
        ),
        children: [
          _description(),
          _indications(),
          _categories(),
        ]);
  }

  TextSpan _description() {
    return TextSpan(
        text: ", " + location.desc.toString().toLowerCase(),
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w300,
          color: App.themex.primaryColor,
        ));
  }

  TextSpan _indications() {
    return TextSpan(
        text:
            "\n\nQui ci sarà la parte dei consigli su come raggiungere il luogo e altri piccoli consigli.",
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w300,
          color: App.themex.primaryColor,
        ));
  }

  TextSpan _categories() {
    return TextSpan(
        text: "\n\n#mare #italy #ladolcevita #estate",
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w400,
          color: App.themex.primaryColor,
        ));
  }

  Widget _menuIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: InkWell(
        onTap: () => toggleDetailMenu(),
        child: expanded
            ? Icon(Icons.close, color: App.themex.primaryColor)
            : Icon(Iconsax.maximize_4, color: App.themex.primaryColor),
      ),
    );
  }
}