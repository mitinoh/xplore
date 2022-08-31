import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/like_button.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/utils/imager.dart';

class DetailLocationModal extends StatelessWidget {
  DetailLocationModal(
      {Key? key,
      required this.loc,
      this.fromLikedSection = false,
      this.callback})
      : super(key: key);
  final LocationModel loc;
  final bool
      fromLikedSection; // Passare true se viene richiamata dalla sezione salvati
  final VoidCallback? callback;

  //final HomeBloc _locationBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  show(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);

    showModalBottomSheet<void>(
        //useRootNavigator: true,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: lightDark.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              height: mediaQuery.size.height * 0.84,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.lightBlue,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        Img.getLocationUrl(loc),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const LoadingIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Icon(Iconsax.gallery_slash,
                                          size: 30, color: Colors.red),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: loc.insertUid?.username,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: lightDark.primaryColor)),
                                    TextSpan(
                                        text: ' LV. 4',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.lightBlue))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                  onTap: () => {
                                    /*
                                        _mapRepository.openMap(
                                            loc.geometry?.coordinates?[0] ??
                                                0.0,
                                            loc.geometry?.coordinates?[1] ??
                                                0.0)
                                                */
                                      },
                                  child: Icon(
                                    Iconsax.discover_1,
                                    color: lightDark.primaryColor,
                                  )),
                            ),
                            LikeButton(
                              locationList: loc,
                              callback: callback,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            textScaleFactor: 1,
                            text: TextSpan(
                                text: "Il colosseo di roma",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: lightDark.primaryColor),
                                children: [
                                  TextSpan(
                                      text:
                                          " - lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: lightDark.primaryColor)),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(loc.name ?? '',
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: lightDark.primaryColor)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ClipRRect(
                        child: CachedNetworkImage(
                      height: mediaQuery.size.height * 0.45,
                      width: mediaQuery.size.height * 1,
                      imageUrl: Img.getLocationUrl(loc),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: lightDark.primaryColor)),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => {
                            /*
                            _mapRepository.openMap(
                                loc.geometry?.coordinates?[0] ?? 0.0,
                                loc.geometry?.coordinates?[1] ?? 0.0)
                                */
                          },
                          child: Text(
                            "raggiungi con google maps",
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: lightDark.primaryColor),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            text: TextSpan(
                              text: "via del successo, piacenza 29120",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: lightDark.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}