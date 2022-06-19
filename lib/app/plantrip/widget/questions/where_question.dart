import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/header_name.dart';
import 'package:xplore/core/widgets/subtitle.dart';

class WhereQuestion extends StatefulWidget {
  WhereQuestion({Key? key, required this.context}) : super(key: key);
  BuildContext context;

  @override
  State<WhereQuestion> createState() => _WhereQuestionState();
}

class _WhereQuestionState extends State<WhereQuestion> {
  String _locationFound = "";

  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    String? contextName =
        context.read<PlantripBloc>().planTripQuestionsMap["locationNam"];

    if (contextName != null)
      setState(() {
        _locationController.text = contextName;
      });
    setLocationIfExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const Subtitle(
              text:
                  "Parti per una breve vacanza o invece per una lunga oppure semplicemente in giornata.",
              colors: Colors.grey,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderName(message: "Dove vorresti andare ", questionMark: true)
              ],
            ),
            const SizedBox(height: 20),
            const Subtitle(
              text:
                  "Scegli una città come destinazione e ti aiuteremo a scoprire le attrazioni più belle.",
              colors: Colors.black,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 5, top: 5),
                      decoration: BoxDecoration(
                          color: UIColors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        onEditingComplete: () {
                          setLocationName();
                        },
                        controller: _locationController,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Inserisci destinazione",
                          hintStyle:
                              TextStyle(color: UIColors.grey, fontSize: 14),
                          border: const OutlineInputBorder(),
                          prefixIcon: Icon(
                            Iconsax.flag,
                            color: UIColors.blue,
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Subtitle(
                      text:
                          "es. Roma, Milano, Venezia, Firenze, Napoli Torino...",
                      colors: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                text: 'Luogi trovati\n',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: _locationFound.toString(),
                                    style: GoogleFonts.poppins(
                                        color: UIColors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () => {
            getCoordinate(_locationController.text.toString()),
          },
          child: const ConfirmButton(text: "prossima domanda"),
        ),
      ],
    );
  }

  void getCoordinate(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      context.read<PlantripBloc>().planTripQuestionsMap["latitude"] =
          locations[0].latitude;
      context.read<PlantripBloc>().planTripQuestionsMap["longitude"] =
          locations[0].longitude;
      context.read<PlantripBloc>().planTripQuestionsMap["locationNam"] =
          location;
      context
          .read<PlantripBloc>()
          .add(PlanTripChangeQuestionEvent(increment: true));
      //locLatitude = locations[0].latitude;
      //locLongitude = locations[0].longitude;

      //incrementQuest();
    } catch (e) {
      context
          .read<PlantripBloc>()
          .add(PlanTripLocationNotFound(message: 'mess111'));
      // _planTripBloc.add(PlanTripLocationNotFound(message: 'mess111'));
    }
  }

  Future<void> setLocationName({double? lat, double? lng}) async {
    double latitude = 0;
    double longitude = 0;
    if (lat == null || lng == null) {
      List<Location> locations =
          await locationFromAddress(_locationController.text);
      latitude = locations[0].latitude;
      longitude = locations[0].longitude;
    } else {
      latitude = lat;
      longitude = lng;
    }
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    setState(() {
      _locationFound = place.locality! +
          ', ' +
          place.postalCode! +
          ', ' +
          place.country! +
          ', ';
    });
  }

  setLocationIfExist() {
    double lat =
        context.read<PlantripBloc>().planTripQuestionsMap["latitude"] ?? 0;
    double lng =
        context.read<PlantripBloc>().planTripQuestionsMap["longitude"] ?? 0;
    setLocationName(lat: lat, lng: lng);
  }
}
