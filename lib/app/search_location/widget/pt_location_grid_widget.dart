import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';

class PtLocationGrid extends StatelessWidget {
  const PtLocationGrid({
    Key? key,
    required this.locationList,
  }) : super(key: key);

  final List<Location> locationList;

  double getRndSize() {
    double size = Random().nextInt(250).toDouble();
    if (size < 150) size = 150;
    return size;
  }

  List<Widget> getLocationCnt(context) {
    List<Widget> locCnt = [];
    var mediaQuery = MediaQuery.of(context);
    for (var el in locationList) {
      {
        locCnt.add(InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: UIColors.bluelight,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: getRndSize(),
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          'https://images.unsplash.com/photo-1528744598421-b7b93e12df15?ixlib=rb-1.2.1&ixid=&auto=format&fit=crop&w=928&q=80',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const LoadingIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Iconsax.gallery_slash,
                            size: 30, color: UIColors.lightRed),
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
                        color: UIColors.white.withOpacity(0.6),
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MasonryGrid(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          column: 2,
          children: getLocationCnt(context)),
    );
  }
}
