import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/enum/geo_json_type.dart';
import 'package:xplore/data/model/geometry_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/common_widgets/subtitle.dart';
import 'package:xplore/presentation/screen/map/widget/bs_map.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';

class WhereQuestion extends StatefulWidget {
  WhereQuestion({
    Key? key,
  }) : super(key: key);

  @override
  State<WhereQuestion> createState() => _WhereQuestionState();
}

class _WhereQuestionState extends State<WhereQuestion> {
  String? _locationFound;
  bool _hasFoundLocation = false;

  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    String? contextName =
        BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.destinationName;

    if (contextName != null) {
      setState(() {
        _locationController.text = contextName;
      });
      setLocationIfExist();
    }

    super.initState();
  }

  late ThemeData themex = Theme.of(context);
  @override
  Widget build(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Subtitle(
              text:
                  "Answer a few simple questions and we'll help you find inspiration for your next vacation.",
              colors: themex.disabledColor,
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HeaderName(message: "Where would you go", questionMark: true)],
            ),
            const SizedBox(height: 20),
            Subtitle(
              text:
                  "Choose a city as your destination and we will help you discover the most beautiful attractions.",
              colors: themex.disabledColor,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Subtitle(
                      text: "es. Rome, Barcelona, Paris, Las Vegas...",
                      colors: themex.disabledColor,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                              color: themex.cardColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            onEditingComplete: () {
                              setLocationName();
                            },
                            controller: _locationController,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Destination",
                              hintStyle: GoogleFonts.poppins(
                                  color: themex.disabledColor, fontSize: 14),
                              border: const OutlineInputBorder(),
                              prefixIcon: Icon(
                                Iconsax.location,
                                color: themex.indicatorColor,
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            builder: (ct) {
                              return MapsBottomSheet(
                                context: context,
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: themex.cardColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Icon(
                                Iconsax.map,
                                color: themex.indicatorColor,
                              ),
                            ),
                            Text(
                              "Choose on map",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: themex.disabledColor),
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
                                          ? 'Locations found\n'
                                          : 'No location found',
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
                text: "Next question",
                colors: themex.primaryColor,
                colorsText: themex.canvasColor))
      ],
    );
  }

  void getCoordinate(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      GeometryModel geo = GeometryModel(
          type: GeoJSONType.Point,
          coordinates: [locations[0].longitude, locations[0].latitude]);

      BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.geometry = geo;
      BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.destinationName =
          location;
      BlocProvider.of<PlannerQuestionBloc>(context).add(PlannerChangeQuestion());

    } catch (e) {
      BlocProvider.of<PlannerQuestionBloc>(context)
          .add(PlannerQuestionErrorEvent(message: "No location found"));
    }
  }

  Future<void> setLocationName({double? lat, double? lng}) async {
    try {
      double latitude = 0;
      double longitude = 0;
      if (lat == null || lng == null) {
        List<Location> locations = await locationFromAddress(_locationController.text);
        latitude = locations[0].latitude;
        longitude = locations[0].longitude;
      } else {
        latitude = lat;
        longitude = lng;
      }
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      setState(() {
        _hasFoundLocation = true;

        _locationFound = '${place.locality}, ${place.postalCode}, ${place.country}';
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
