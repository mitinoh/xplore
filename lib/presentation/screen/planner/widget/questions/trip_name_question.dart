import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';

// ignore: must_be_immutable
class TripNameQuestion extends StatelessWidget {
  TripNameQuestion({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();

  initState(BuildContext context) {
    String? contextName =
        BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.tripName;
    if (contextName != null) _nameController.text = contextName;

    themex = Theme.of(context);
  }

  late ThemeData themex;
  @override
  Widget build(context) {
    initState(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HeaderName(message: "Name your holiday")],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Go wild and find an interesting name for your next trip. 😜",
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: themex.disabledColor)),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: themex.indicatorColor, fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Vacation name",
                      hintStyle:
                          GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(
                        Iconsax.note,
                        color: themex.indicatorColor,
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
            if (_nameController.text.trim() != "")
              {
                BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.tripName =
                    _nameController.text,
                BlocProvider.of<PlannerQuestionBloc>(context).add(PlannerChangeQuestion())
              }
            else
              {
                BlocProvider.of<PlannerQuestionBloc>(context)
                    .add(PlannerQuestionErrorEvent(message: 'Trip name cannot be empty'))
              }
          },
          child: ConfirmButton(
              text: "Let's go",
              colors: themex.primaryColor,
              colorsText: themex.canvasColor),
        ),
      ],
    );
  }
}
