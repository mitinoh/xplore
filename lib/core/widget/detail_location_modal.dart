import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/map/bloc/map_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/location_model.dart';

class DetailLocationModal extends StatelessWidget {
  DetailLocationModal({Key? key, required this.loc, required this.mapBloc})
      : super(key: key);
  final Location loc;
  final MapBloc mapBloc;

  Config conf = Config();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  show(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    showModalBottomSheet<void>(
        //useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: const Color(0xffF3F7FA),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            height: mediaQuery.size.height * 0.75,
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
                            backgroundColor: UIColors.blue,
                            backgroundImage: NetworkImage(
                                conf.getLocationImageUrl(loc.iId ?? '')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'mite.g'.toLowerCase(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: ' LV. 4',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: UIColors.blue))
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
                                      mapBloc.add(OpeningExternalMap(
                                          loc.coordinate?.lat ?? 0.0,
                                          loc.coordinate?.lng ?? 0.0))
                                    },
                                child: const Icon(Iconsax.discover_1)),
                          ),
                          Icon(Iconsax.heart,
                              color: loc.saved == true
                                  ? UIColors.lightRed
                                  : UIColors.black)
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
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text:
                                        " - lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey)),
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
                              color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ClipRRect(
                      child: CachedNetworkImage(
                    height: mediaQuery.size.height * 0.45,
                    width: mediaQuery.size.height * 1,
                    imageUrl: conf.getLocationImageUrl(loc.iId ?? ''),
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
                                color: Colors.grey)),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => {
                          mapBloc.add(OpeningExternalMap(
                              loc.coordinate?.lat ?? 0.0,
                              loc.coordinate?.lng ?? 0.0))
                        },
                        child: Text(
                          "raggiungi con google maps",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
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
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
