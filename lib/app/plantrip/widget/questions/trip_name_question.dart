import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/header_name.dart';

class TripNameQuestion extends StatelessWidget {
  TripNameQuestion({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  @override
  Widget build(context) {
    final TextEditingController _nameController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderName(
                    message: "Dai un nome alla tua vacanza ",
                    questionMark: false)
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
                          color: Colors.grey)),
                )
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
                  child: TextFormField(
                    controller: _nameController,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Nome vacanza",
                      hintStyle: TextStyle(color: UIColors.grey, fontSize: 14),
                      border: const OutlineInputBorder(),
                      suffixIconColor: UIColors.blue,
                      prefixIcon: Icon(
                        Iconsax.note,
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
            if (_nameController.text != null &&
                _nameController.text.trim() != "")
              {
                context.read<PlantripBloc>().planTripQuestionsMap["tripName"] =
                    _nameController.text,
                context
                    .read<PlantripBloc>()
                    .add(PlanTripChangeQuestionEvent(increment: true))

                /*
                planQuery.putIfAbsent("tripName", () => _nameController.text),
                if (_planTripBloc.isClosed) {_planTripBloc = PlantripBloc()},
                _planTripBloc.add(
                    GetLocation(/*body: planQuery.toString(),*/ mng: mng)),
                incrementQuest()
                */
              }
            else
              {
                context.read<PlantripBloc>().add(PlanTripLocationNotFound(
                    message: 'trip name cannot be empty'))
              }
          },
          child: const ConfirmButton(text: "continua"),
        ),
      ],
    );
  }
}
