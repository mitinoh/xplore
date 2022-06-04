import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';

class HeaderOnboarding extends StatelessWidget {
  const HeaderOnboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SizedBox(
      child: MasonryGrid(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        column: 2,
        children: [
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
                color: UIColors.bluelight,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: 175,
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          'https://images.unsplash.com/photo-1568992852331-1d1a1ca6c78c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
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
                            'Roma',
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
          Container(
            decoration: BoxDecoration(
                color: UIColors.bluelight,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: 200,
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          'https://images.unsplash.com/photo-1582070915618-9140bdc5035e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=80',
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
                            'New York',
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
          Container(
            decoration: BoxDecoration(
                color: UIColors.bluelight,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: 210,
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          'https://images.unsplash.com/photo-1569949384963-296c0f251fbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
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
                            'Parigi',
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
          Container(
            decoration: BoxDecoration(
                color: UIColors.bluelight,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      height: 200,
                      width: mediaQuery.size.height * 1,
                      imageUrl:
                          'https://images.unsplash.com/photo-1588266413414-e042aa4831f0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
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
                            'Londra',
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
        ],
      ),
    );
  }
}
