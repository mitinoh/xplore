import 'package:flutter/material.dart';
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

  late MediaQueryData mediaQueryX;
  late ThemeData themex;

  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    mediaQueryX = MediaQuery.of(context);

    return _buildAnimationMenu();
  }

  Positioned _buildAnimationMenu() => Positioned(
      child: AnimatedContainer(
        height: expanded ? 340 : 82,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: themex.scaffoldBackgroundColor),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 24),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        duration: const Duration(seconds: 1),
        curve: Curves.bounceOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildInfoContainer(), _buildMenuIcon()],
        ),
      ),
      bottom: 0,
      right: 0,
      left: 0);

  Widget _buildInfoContainer() => Expanded(
        child: SingleChildScrollView(
          child: RichText(
            textScaleFactor: 1,
            text: _buildInfoGroup(),
          ),
        ),
      );

  TextSpan _buildInfoGroup() => TextSpan(
          text: location.name,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: themex.indicatorColor,
          ),
          children: [
            _buildDescription(),
            _buildIndications(),
            _buildCategories(),
          ]);

  TextSpan _buildDescription() => TextSpan(
      text: ", " + location.desc.toString().toLowerCase(),
      style: GoogleFonts.poppins(
        fontSize: 12.5,
        fontWeight: FontWeight.w300,
        color: themex.indicatorColor,
      ));

  TextSpan _buildIndications() => TextSpan(
      text: location.indication,
      style: GoogleFonts.poppins(
        fontSize: 12.5,
        fontWeight: FontWeight.w300,
        color: themex.indicatorColor,
      ));

  TextSpan _buildCategories() => TextSpan(
      text: '\n#' +
          (location.locationCategory
                  ?.map((category) => category.name)
                  .toList()
                  .join(', #') ??
              ''),
      style: GoogleFonts.poppins(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        color: themex.indicatorColor,
      ));

  Widget _buildMenuIcon() => Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: InkWell(
          onTap: () => toggleDetailMenu(),
          child: expanded
              ? Icon(Icons.close, color: themex.indicatorColor)
              : Icon(Iconsax.maximize_4, color: themex.indicatorColor),
        ),
      );
}
