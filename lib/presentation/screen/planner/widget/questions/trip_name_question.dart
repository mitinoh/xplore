import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/question_bloc.dart';

// ignore: must_be_immutable
class TripNameQuestion extends StatelessWidget {
  TripNameQuestion({Key? key}) : super(key: key);


  final TextEditingController _nameController = TextEditingController();

  initState(BuildContext context) {
    String? contextName =
       BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.tripName;
    if (contextName != null) _nameController.text = contextName;
  }

  @override
  Widget build(context) {
    var lightDark = Theme.of(context);
    initState(context);
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
                          color: lightDark.primaryColor)),
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
                      color: lightDark.cardColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: lightDark.hoverColor, fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Nome vacanza",
                      hintStyle: GoogleFonts.poppins(
                          color: lightDark.unselectedWidgetColor, fontSize: 14),
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(
                        Iconsax.note,
                        color: Colors.blue,
                      ),
                    ),
                    autofocus: false,
                  ),
                ))
              ],
            )
          ],
        ),
        InkWell(
          onTap: () => {
            if (_nameController.text != null &&
                _nameController.text.trim() != "")
              {
               BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.tripName =
                    _nameController.text,
                BlocProvider.of<PlannerQuestionBloc>(context)
                    .add(PlannerChangeQuestion())

                //planQuery.putIfAbsent("tripName", () => _nameController.text),
                //if (_planTripBloc.isClosed) {_planTripBloc = PlantripBloc()},
                //_planTripBloc.add(
                //    GetLocation(/*body: planQuery.toString(),*/ mng: mng)),
                //incrementQuest()
              }
            else
              {
               BlocProvider.of<PlannerQuestionBloc>(context).add(
                    PlannerQuestionErrorEvent(message: 'trip name cannot be empty'))
              }
          },
          child: ConfirmButton(
            text: "prossima domanda",
            colors: Colors.blue,
            colorsText: Colors.black,
          ),
        ),
      ],
    );
  }
}
