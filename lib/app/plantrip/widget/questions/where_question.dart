import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/header_name.dart';

class WhereQuestion extends StatelessWidget {
  WhereQuestion({Key? key, required this.context}) : super(key: key);
  BuildContext context;

  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(context) {
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
                HeaderName(message: "Dove vorresti andare ", questionMark: true)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Scegli una città come destinazione e ti aiuteremo a scoprire le attrazioni più belle.",
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Milano, ',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                        TextSpan(
                            text: 'Roma, ',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                        TextSpan(
                            text: 'Firenze, ',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                        TextSpan(
                            text: 'Venezia, ',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                        TextSpan(
                            text: 'Lago di garda...',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      color: UIColors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Inserisci destinazione",
                      hintStyle: TextStyle(color: UIColors.grey, fontSize: 14),
                      border: const OutlineInputBorder(),
                      suffixIconColor: UIColors.blue,
                      prefixIcon: Icon(
                        Iconsax.flag,
                        color: UIColors.blue,
                      ),
                    ),
                    autofocus: false,
                  ),
                ))
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () => {
            getCoordinate(_nameController.text.toString()),
          },
          child: const ConfirmButton(text: "continua"),
        ),
      ],
    );
  }

  void getCoordinate(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);

      context.read<PlantripBloc>().planTripQuestionsMap["location"] = location;
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
}
