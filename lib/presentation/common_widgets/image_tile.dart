import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/utils/imager.dart';

class ImageTile extends StatelessWidget {
  ImageTile({Key? key, required this.location}) : super(key: key);
  LocationModel location;

  late ThemeData themex;

  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: themex.indicatorColor, borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ImageWidget(imageUrl: Img.getLocationUrl(location)))),
          Positioned(
            bottom: 5,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                  color: themex.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      location.name!.toLowerCase(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: themex.indicatorColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
