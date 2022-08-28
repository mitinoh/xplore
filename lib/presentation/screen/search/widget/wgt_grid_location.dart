import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';

class LocationGridWidget extends StatelessWidget {
  LocationGridWidget({Key? key, required this.locationsList}) : super(key: key);

  final List<LocationModel> locationsList;
  late MediaQueryData _mediaQuery;
  late ThemeData _lightDark;
  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _lightDark = Theme.of(context);
    return SizedBox(
      child: MasonryGrid(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          column: 2,
          children: getLocationCnt(context)),
    );
  }

  List<Widget> getLocationCnt(context) {
    List<Widget> locCnt = [];
    var mediaQuery = MediaQuery.of(context);
    for (var el in locationsList) {
      {
        locCnt.add(InkWell(
          onTap: () {
            // DetailLocationModal(loc: el).show(context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: getRndSize(),
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          "https://107.174.186.223.nip.io/img/location/${el.id}.jpg",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const LoadingIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Iconsax.gallery_slash,
                            size: 30, color: Colors.red),
                      ),
                    )),
                Positioned(
                  bottom: 5,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            el.name ?? '',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      }
    }

    return locCnt;
  }

  double getRndSize() {
    double size = Random().nextInt(250).toDouble();
    if (size < 150) size = 150;
    return size;
  }
}
