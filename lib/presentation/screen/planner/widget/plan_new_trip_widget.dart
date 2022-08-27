import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/progressbar.dart';
import 'package:xplore/presentation/common_widgets/success_screen.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/presentation/screen/planner/widget/planner_header_commands.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/avoid_category_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/distance_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/period_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/select_trip_location_widget.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/trip_name_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/where_question.dart';

class NetTripQuestion extends StatefulWidget {
  NetTripQuestion({Key? key, required this.callback}) : super(key: key);
  final VoidCallback? callback;
  // https://pub.dev/packages/drag_and_drop_lists

   GlobalKey<_NetTripQuestionState> netTripQuestionState =
      GlobalKey<_NetTripQuestionState>();

  @override
  State<NetTripQuestion> createState() => _NetTripQuestionState();
}

class _NetTripQuestionState extends State<NetTripQuestion> {
  //late ValueChanged<bool> onChange = false;

  //ValueChanged<int> onChangee = new ValueChanged(2);
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime goneDate = DateTime.now().add(const Duration(hours: 1));
  DateTime returnDate =
      DateTime.now().add(const Duration(hours: 1)); //DateUtils.dateOnly(

  int questNum = 0;
  double valueProgressIndicator = 0.166;
  //double _currentSliderValue = 20;
  Map<String, dynamic> planQuery = {};

  double locLatitude = 0;
  double locLongitude = 0;
  @override
  void initState() {
    //_locCatBloc.add(GetLocationCategoryList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlocProvider.of<PlannerQuestionBloc>(context),
      child: BlocListener<PlannerQuestionBloc, PlannerQuestionState>(
        listener: (context, state) {
          if (state is PlannerQuestionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message.toString()),
              ),
            );
          } else if (state is PlannerNextQuestion) {
            setState(() {
              valueProgressIndicator += 0.166;
              questNum++;

            });
          } else if (state is PlannerPreviousQuestion) {
            if (questNum != 0) {
              setState(() {
                valueProgressIndicator -= 0.166;
                questNum--;
              });
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: BlocBuilder<PlannerQuestionBloc, PlannerQuestionState>(
          builder: (ctz, state) {
            if (state is PlannerQuestionCompleted) {
              return InkWell(
                onTap: () {
                  widget.callback!();
                  Navigator.pop(context);
                },
                child: const SuccessScreen(
                  title: "Viaggio pianificato",
                  subtitle:
                      "Abbiamo pianificato la tua vacanza, buona fortuna e altre stronzate da radical chic.",
                ),
              );
            }
            // if (state is PlanTripQuestion) {print(context
            Widget questionWidget;
            switch (questNum) {
              case 0:
                questionWidget = WhereQuestion();
                break;
              case 1:
                questionWidget = PeriodQuestion();
                break;
              case 2:
                questionWidget = AvoidCategoryQuestion();
                break;
              case 3:
                questionWidget = DistanceQuestion();
                break;
              case 4:
                questionWidget = TripNameQuestion();
                break;
              case 5:
                questionWidget = SelectTripLocation();
                // questionWidget = SelectTripLocation( );
                break;
              default:
                return Scaffold(
                  body: SafeArea(
                    child: Container(),
                  ),
                );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlannerHeaderCommand(
                  onCountSelected: () {
                    decrementQuest();
                  },
                ),
                const SizedBox(height: 30),
                ProgressBar(valueProgressIndicator: valueProgressIndicator),
                const SizedBox(height: 30),
                Expanded(child: questionWidget),
              ],
            );
            /* } else */

            //  return Text("1");
          },
        ),
      ),
    );
  }

  void decrementQuest() {
    BlocProvider.of<PlannerQuestionBloc>(context)
        .add(PlannerChangeQuestion(increment: false));
  }
}
