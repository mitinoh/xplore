import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/common_widgets/progressbar.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';
import 'package:xplore/presentation/common_widgets/success_screen.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/presentation/screen/planner/widget/wg_planner_header_commands.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/avoid_category_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/distance_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/period_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/select_trip_location_widget.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/trip_name_question.dart';
import 'package:xplore/presentation/screen/planner/widget/questions/where_question.dart';

class NetTripQuestion extends StatefulWidget {
  NetTripQuestion({Key? key, required this.callback}) : super(key: key);
  final VoidCallback? callback;

  @override
  State<NetTripQuestion> createState() => _NetTripQuestionState();
}

class _NetTripQuestionState extends State<NetTripQuestion> {
  int questNum = 0;
  double valueProgressIndicator = 0.166;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => BlocProvider.of<PlannerQuestionBloc>(context),
        child: BlocListener<PlannerQuestionBloc, PlannerQuestionState>(
            listener: (context, state) {
          _blocListener(state);
        }, child: BlocBuilder<PlannerQuestionBloc, PlannerQuestionState>(
                builder: (context, state) {
          return _blocBuilder(state);
        })));
  }

  Widget _getQuestionWidget() {
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
        questionWidget = Scaffold(
          body: SafeArea(
            child: Container(),
          ),
        );
    }
    return questionWidget;
  }

  Widget _progressBar() {
    return ProgressBar(valueProgressIndicator: valueProgressIndicator);
  }

  Widget _blocBuilder(PlannerQuestionState state) {
    if (state is PlannerQuestionCompleted) {
      return InkWell(
        onTap: () {
          widget.callback!();
          Navigator.pop(context);
        },
        child: SuccessScreen(
          title: "Holiday created",
          subtitle:
              "We've got your vacation planned, good luck and other radical chic bullshit.",
        ),
      );
    }  else {
      Widget questionWidget = _getQuestionWidget();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlannerHeaderCommandWidget(
            onQuestionChange: () {
              _decrementQuest();
            },
          ),
          const SizedBox(height: 30),
          _progressBar(),
          const SizedBox(height: 30),
          Expanded(child: questionWidget),
        ],
      );
    }
  }

  void _blocListener(PlannerQuestionState state) {
    if (state is PlannerNextQuestion) {
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
    } else if (state is PlannerQuestionError) {
      SbError().show(context, state.message);
    }
  }

  void _decrementQuest() {
    BlocProvider.of<PlannerQuestionBloc>(context)
        .add(PlannerChangeQuestion(increment: false));
  }
}
