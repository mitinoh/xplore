import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';

class PeriodQuestion extends StatefulWidget {
  PeriodQuestion({Key? key}) : super(key: key);

  @override
  State<PeriodQuestion> createState() => _PeriodQuestionState();
}

class _PeriodQuestionState extends State<PeriodQuestion> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');

  DateTime goneDate = DateTime.now().add(const Duration(hours: 1));
  DateTime returnDate =
      DateTime.now().add(const Duration(hours: 1)); //DateUtils.dateOnly(

  @override
  void initState() {
    DateTime? goneContext =
        BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.goneDate;

    DateTime? returnContext =
        BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.returnDate;
    setState(() {
      if (goneContext != null) goneDate = goneContext;

      if (returnContext != null) returnDate = returnContext;
    });
    super.initState();
  }

  late ThemeData themex;

  @override
  Widget build(context) {
    themex = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderName(message: "When would you like to leave", questionMark: true)
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                      "Now select the duration of your vacation, entering the departure and return dates.",
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: themex.disabledColor)),
                )
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => {_pickDateDialog(true)},
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: themex.cardColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Icon(
                        Iconsax.calendar_add,
                        color: themex.indicatorColor,
                      ),
                    ),
                    Text(
                      "Departure date",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: themex.indicatorColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => {_pickDateDialog(false)},
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: themex.cardColor,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Icon(
                        Iconsax.calendar_add,
                        color: themex.indicatorColor,
                      ),
                    ),
                    Text("Return date",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: themex.indicatorColor)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Leave day: ',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: themex.disabledColor),
                children: <TextSpan>[
                  TextSpan(
                      text: formatter.format(goneDate).toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: themex.primaryColor)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: 'Return day',
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                      text: formatter.format(returnDate).toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: themex.primaryColor)),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            if (returnDate.isBefore(goneDate)) {
              BlocProvider.of<PlannerQuestionBloc>(context).add(PlannerQuestionErrorEvent(
                  message: 'Are you a time traveler by chance?'));
            } else {
              List<int> dayAvaiable = [];
              for (int i = goneDate.weekday; i < returnDate.weekday; i++) {
                dayAvaiable.add(i);
              }

              /*
            planQuery["totDay"] = returnDate.difference(goneDate).inDays;
            planQuery["periodAvaiable"] = getSeason(goneDate.month);
            planQuery["dayAvaiable"] = dayAvaiable;
            */

              BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.goneDate =
                  goneDate;
              BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.returnDate =
                  returnDate;

              BlocProvider.of<PlannerQuestionBloc>(context).add(PlannerChangeQuestion());
            }
          },
          child: ConfirmButton(
              text: "Next question",
              colors: themex.primaryColor,
              colorsText: themex.canvasColor),
        ),
      ],
    );
  }

  void setTripDate(bool gone, pickedDate) {
    // setState(() {
    if (gone) {
      setState(() {
        goneDate = DateUtils.dateOnly(pickedDate);
      });

      //  mng.filter?.putIfAbsent("goneDate", () => goneDate);
      // planQuery["goneDate"] = goneDate.millisecondsSinceEpoch;
    } else {
      setState(() {
        returnDate = DateUtils.dateOnly(pickedDate);
      });
      //  mng.filter?.putIfAbsent("returnDate", () => returnDate);
      // planQuery["returnDate"] =  returnDate.millisecondsSinceEpoch;
    }
    //  });
  }

  void _pickDateDialog(bool gone) {
    // quardare https://pub.dev/packages/flutter_cupertino_date_picker#-readme-tab-

    if (Platform.isAndroid) {
      showDatePicker(
              context: context,
              initialDate: goneDate,
              firstDate: gone ? DateTime.now() : goneDate,
              lastDate: DateTime.now()) //what will be the up to supported date in picker
          .then((pickedDate) {
        //then usually do the future job
        if (pickedDate == null) {
          //if user tap cancel then this function will stop
          return;
        }
        setTripDate(gone, pickedDate);
      });
    } else if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
                height: 350,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Color(0xffF3F7FA),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: CupertinoDatePicker(
                          initialDateTime: goneDate,
                          minimumDate: gone ? DateTime.now() : goneDate,
                          onDateTimeChanged: (pickedDate) {
                            setTripDate(gone, pickedDate);
                          }),
                    ),
                  ],
                ),
              ));
    }
  }
}
