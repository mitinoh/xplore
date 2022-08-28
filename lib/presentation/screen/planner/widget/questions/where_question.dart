import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/enum/geo_json_type.dart';
import 'package:xplore/data/model/geometry_model.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/common_widgets/subtitle.dart';
import 'package:xplore/presentation/screen/planner/bloc/plan_state.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/question_bloc.dart';
import 'package:xplore/presentation/screen/planner/widget/wg_plan_new_trip.dart';
import 'package:xplore/utils/logger.dart';

class WhereQuestion extends StatefulWidget {
  WhereQuestion({
    Key? key,
  }) : super(key: key);

  //final ValueChanged<void> callback;

  @override
  State<WhereQuestion> createState() => _WhereQuestionState();
}

class _WhereQuestionState extends State<WhereQuestion> {
  String? _locationFound;
  bool _hasFoundLocation = false;

  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    String? contextName = BlocProvider.of<PlannerQuestionBloc>(context)
        .planTripQuestions
        .destinationName;

    if (contextName != null) {
      setState(() {
        _locationController.text = contextName;
      });
      setLocationIfExist();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    var lightDark = Theme.of(context);

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
            Subtitle(
              text:
                  "Scegli una città come destinazione e ti aiuteremo a scoprire le attrazioni più belle.",
              colors: lightDark.primaryColor,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const Subtitle(
                      text:
                          "es. Roma, Milano, Venezia, Firenze, Napoli Torino...",
                      colors: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                              color: lightDark.cardColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            onEditingComplete: () {
                              setLocationName();
                            },
                            controller: _locationController,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: lightDark.hoverColor, fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Desitanazione",
                              hintStyle: GoogleFonts.poppins(
                                  color: lightDark.unselectedWidgetColor,
                                  fontSize: 14),
                              border: const OutlineInputBorder(),
                              prefixIcon: Icon(
                                Iconsax.location,
                                color: Colors.blue,
                              ),
                            ),
                            autofocus: false,
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            backgroundColor: lightDark.backgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            builder: (ct) {
                              return Text("MapsBottomSheet");
                              /*

                              return MapsBottomSheet(
                                context: context,
                              );
                              */
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: lightDark.cardColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, left: 15),
                              child: Icon(
                                Iconsax.map,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "Cerca dalla mappa",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: lightDark.hoverColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _locationFound != null
                        ? Row(
                            children: [
                              Expanded(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text: _hasFoundLocation
                                          ? 'Luoghi trovati\n'
                                          : 'nessun luogo trovato',
                                      style: GoogleFonts.poppins(
                                          color: _hasFoundLocation
                                              ? Colors.black
                                              : Colors.red,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: _locationFound?.toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          )
                        : const SizedBox(),
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
          child: ConfirmButton(
            text: "prossimllla domanda",
            colors: Colors.blue,
            colorsText: Colors.black,
          ),
        ),
      ],
    );
  }

  void getCoordinate(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      GeometryModel geo = GeometryModel(
          type: GeoJSONType.Point,
          coordinates: [locations[0].longitude, locations[0].latitude]);

      BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.geometry =
          geo;
      BlocProvider.of<PlannerQuestionBloc>(context)
          .planTripQuestions
          .destinationName = location;
/*
      BlocProvider.of<PlannerQuestionBloc>(context)
          .planTripQuestionsMap["latitude"] = locations[0].latitude;
      BlocProvider.of<PlannerQuestionBloc>(context)
          .planTripQuestionsMap["longitude"] = locations[0].longitude;
      BlocProvider.of<PlannerQuestionBloc>(context)
          .planTripQuestionsMap["locationNam"] = location;

*/
      BlocProvider.of<PlannerQuestionBloc>(context)
          .add(PlannerChangeQuestion());
      //locLatitude = locations[0].latitude;
      //locLongitude = locations[0].longitude;

      //incrementQuest();
    } catch (e) {
      BlocProvider.of<PlannerQuestionBloc>(context)
          .add(PlannerQuestionErrorEvent(message: "nessun posto trovato"));
      // context.read<PlannerQuestionBloc>().add(PlanTripErrorEvent(message: 'mess111'));
      // _planTripBloc.add(PlanTripErrorEvent(message: 'mess111'));
    }
  }

  Future<void> setLocationName({double? lat, double? lng}) async {
    try {
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
        _hasFoundLocation = true;

        _locationFound =
            '${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      setState(() {
        _locationFound = '';
        _hasFoundLocation = false;
      });
    }
  }

  setLocationIfExist() {
    double lat = BlocProvider.of<PlannerQuestionBloc>(context)
            .planTripQuestions
            .geometry
            ?.coordinates?[1] ??
        0;
    double lng = BlocProvider.of<PlannerQuestionBloc>(context)
            .planTripQuestions
            .geometry
            ?.coordinates?[0] ??
        0;
    setLocationName(lat: lat, lng: lng);
  }
}
