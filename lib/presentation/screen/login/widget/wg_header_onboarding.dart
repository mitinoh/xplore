import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/utils/const/LOGIN_CONST.dart';

class HeaderOnboarding extends StatelessWidget {
  const HeaderOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryX = MediaQuery.of(context);
    return _buildMasonryGrid(mediaQueryX);
  }

  MasonryGrid _buildMasonryGrid(MediaQueryData mediaQueryX) => MasonryGrid(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        column: 2,
        children: _buildCard(mediaQueryX),
      );

  List<Widget> _buildCard(MediaQueryData mediaQueryX) {
    List<Widget> _cards = [];
    LOGIN_CONST.locations.forEach(
      (obj) => _cards.add(Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            _buildClip(obj, mediaQueryX),
            _buildName(obj),
          ],
        ),
      )),
    );
    return _cards;
  }

  Positioned _buildName(Map<String, dynamic> obj) => Positioned(
        bottom: 5,
        left: 20,
        right: 20,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  obj["name"],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );

  ClipRRect _buildClip(Map<String, dynamic> obj, MediaQueryData mediaQueryX) => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        height: obj["height"],
        width: mediaQueryX.size.height * 1,
        imageUrl: obj["url"],
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const LoadingIndicator(),
        errorWidget: (context, url, error) => Center(
          child: Icon(Iconsax.gallery_slash, size: 30, color: Colors.red),
        ),
      ));
}
