import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/header_name.dart';

class DistanceQuestion extends StatefulWidget {
  DistanceQuestion({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  @override
  State<DistanceQuestion> createState() => _DistanceQuestionState();
}

class _DistanceQuestionState extends State<DistanceQuestion> {
  double _currentSliderValue = 20;

  @override
  void initState() {
    double? contextDistance =
        context.read<PlantripBloc>().planTripQuestionsMap["distance"];
    if (contextDistance != null) {
      setState(() {
        _currentSliderValue = contextDistance / 1000;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderName(
                    message: "Quanto puoi spostarti ", questionMark: true)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum is simply dummy.",
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: lightDark.primaryColor)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: _currentSliderValue.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                          color: lightDark.primaryColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: " km",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SliderTheme(
              data: SliderThemeData(
                inactiveTickMarkColor: lightDark.primaryColor.withOpacity(0.3),
                activeTickMarkColor: lightDark.primaryColor,
                inactiveTrackColor: lightDark.primaryColor.withOpacity(0.3),
                activeTrackColor: lightDark.primaryColor,
                thumbColor: lightDark.primaryColor,
              ),
              child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            setDistanceLocation();
          },
          child: ConfirmButton(
            text: "prossima domanda",
            colors: UIColors.lightGreen,
          ),
        ),
      ],
    );
  }

  void setDistanceLocation() {
    /*
    double latDis = getLatDis(_currentSliderValue);
    double lngDis = getLngDis(_currentSliderValue, latDis);
    mng.filter?["coordinate.lat=lte:" + (locLatitude + latDis).toString()] =
        null;
    mng.filter?["coordinate.lat=gte:" + (locLatitude - latDis).toString()] =
        null;

    mng.filter?["coordinate.lng=lte:" + (locLongitude + lngDis).toString()] =
        null;

    mng.filter?["coordinate.lng=gte:" + (locLongitude - lngDis).toString()] =
        null;
*/
    // planQuery["distance"] = _currentSliderValue;

    context.read<PlantripBloc>().planTripQuestionsMap["distance"] =
        _currentSliderValue * 1000;
    context
        .read<PlantripBloc>()
        .add(PlanTripChangeQuestionEvent(increment: true));
  }

  double getLatDis(double dis) {
    return dis / 110.574;
  }

  double getLngDis(double dis, double lat) {
    return dis / (111.320 * cos(lat));
  }

  int getSeason(int month) {
    if (month == 8 || month == 10 || month == 11) return 0;
    if (month == 12 || month == 1 || month == 2) return 1;
    if (month == 3 || month == 4 || month == 5) return 2;
    return 3;
  }
}
