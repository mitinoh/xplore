import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/widget/planner_header_commands.dart';
import 'package:xplore/app/plantrip/widget/questions/avoid_category_question.dart';
import 'package:xplore/app/plantrip/widget/questions/distance_question.dart';
import 'package:xplore/app/plantrip/widget/questions/period_question.dart';
import 'package:xplore/app/plantrip/widget/questions/trip_name_question.dart';
import 'package:xplore/app/plantrip/widget/questions/where_question.dart';
import 'package:xplore/app/plantrip/widget/select_trip_location_widget.dart';
import 'package:xplore/core/widgets/progressbar.dart';
import 'package:xplore/core/widgets/success_screen.dart';
import 'package:xplore/model/mongoose_model.dart';

class NetTripQuestion extends StatefulWidget {
  const NetTripQuestion({Key? key, required this.callback}) : super(key: key);
  final VoidCallback? callback;
  // https://pub.dev/packages/drag_and_drop_lists

  @override
  State<NetTripQuestion> createState() => _NetTripQuestionState();
}

class _NetTripQuestionState extends State<NetTripQuestion> {
  final LocationCategoryBloc _locCatBloc = LocationCategoryBloc();

  PlantripBloc _planTripBloc = PlantripBloc();

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
  Mongoose mng = Mongoose(select: [], sort: {});

  double locLatitude = 0;
  double locLongitude = 0;
  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _planTripBloc,
      child: BlocListener<PlantripBloc, PlantripState>(
        listener: (context, state) {
          if (state is PlanTripErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message.toString()),
              ),
            );
          } else if (state is PlanTripNextQuestion) {
            setState(() {
              valueProgressIndicator += 0.166;
              questNum++;
            });
          } else if (state is PlanTripPreviousQuestion) {
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
        child: BlocBuilder<PlantripBloc, PlantripState>(
          builder: (context, state) {
            if (state is PlanTripQuestionCompleted) {
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
                questionWidget = WhereQuestion(context: context);
                break;
              case 1:
                questionWidget = PeriodQuestion(
                  context: context,
                );
                break;
              case 2:
                questionWidget = AvoidCategoryQuestion(
                  context: context,
                );
                break;
              case 3:
                questionWidget = DistanceQuestion(context: context);
                break;
              case 4:
                questionWidget = TripNameQuestion(context: context);
                break;
              case 5:
                questionWidget = SelectTripLocation(
                  context: context,
                );
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
                    decrementQuest(context);
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

  void decrementQuest(BuildContext ctx) {
    ctx.read<PlantripBloc>().add(PlanTripChangeQuestionEvent(increment: false));
  }
/*
  void incrementQuest() {
    setState(() {
      questNum++;
      valueProgressIndicator += 0.166;
    });
  }



  Widget tripNameQuest() {
    final TextEditingController _nameController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            PlannerHeaderCommand(
              count: questNum,
              onCountSelected: () {
                setState(() {
                  decrementQuest(context);
                });
              },
            ),
            const SizedBox(height: 20),
            ProgressBar(valueProgressIndicator: valueProgressIndicator),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Rinomina la tua vacanza ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Mite',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: UIColors.blue)),
                        const TextSpan(text: '?'),
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
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () => {
              if (_nameController.text != null &&
                  _nameController.text.trim() != "")
                {
                  planQuery.putIfAbsent("tripName", () => _nameController.text),
                  if (_planTripBloc.isClosed) {_planTripBloc = PlantripBloc()},
                  _planTripBloc.add(
                      GetLocation(/*body: planQuery.toString(),*/ mng: mng)),
                  incrementQuest()
                }
              else
                {
                  if (_planTripBloc.isClosed) {_planTripBloc = PlantripBloc()},
                  _planTripBloc.add(PlanTripErrorEvent(
                      message: 'trip name cannot be empty'))
                }
            },
            child: const ConfirmButton(text: "continua"),
          ),
        ),
      ],
    );
  }

  Widget whereToGoQuest() {
    final TextEditingController _nameController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            PlannerHeaderCommand(
              count: questNum,
              onCountSelected: () {
                setState(() {
                  if (questNum != 0) {
                    questNum--;
                  }
                  if (questNum == 0) {
                    Navigator.pop(context);
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            ProgressBar(valueProgressIndicator: valueProgressIndicator),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Dove vorresti andare ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Mite',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: UIColors.blue)),
                        const TextSpan(text: '?'),
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

  void setTripDate(bool gone, pickedDate) {
    setState(() {
      if (gone) {
        goneDate = DateUtils.dateOnly(pickedDate);

        mng.filter?.putIfAbsent("goneDate", () => goneDate);
        // planQuery["goneDate"] = goneDate.millisecondsSinceEpoch;
      } else {
        returnDate = DateUtils.dateOnly(pickedDate);
        //  mng.filter?.putIfAbsent("returnDate", () => returnDate);
        // planQuery["returnDate"] =  returnDate.millisecondsSinceEpoch;
      }
    });
  }

  void _pickDateDialog(bool gone) {
    // quardare https://pub.dev/packages/flutter_cupertino_date_picker#-readme-tab-

    if (Platform.isAndroid) {
      showDatePicker(
              context: context,
              initialDate: goneDate,
              firstDate: gone ? DateTime.now() : goneDate,
              lastDate: DateTime
                  .now()) //what will be the up to supported date in picker
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

  Widget periodToGoQuest() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PlannerHeaderCommand(
              count: questNum,
              onCountSelected: () {
                decrementQuest(context);
              },
            ),
            const SizedBox(height: 20),
            ProgressBar(valueProgressIndicator: valueProgressIndicator),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Quando vorresti partire ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Mite',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: UIColors.blue)),
                        const TextSpan(text: '?'),
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
                  child: Text(
                      "Ora seleziona la durata della tua vacanza, inserendo la data di partenza e quella di ritorno.",
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey)),
                )
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => {_pickDateDialog(true)},
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, top: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.grey.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Icon(
                        Iconsax.calendar_add,
                        color: UIColors.blue,
                      ),
                    ),
                    Text(
                      "Data di partenza ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () => {_pickDateDialog(false)},
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, top: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.grey.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15),
                      child: Icon(
                        Iconsax.calendar_add,
                        color: UIColors.blue,
                      ),
                    ),
                    Text(
                      "Data di ritorno ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Hai scelto di partire il giorno ',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                      text: formatter.format(goneDate).toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: 'Giorno di ritorno ',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                      text: formatter.format(returnDate).toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            if (returnDate.isBefore(goneDate)) {
              _planTripBloc.add(PlanTripErrorEvent(
                  message:
                      'la data di ritorno non può essere precedente a quella di partenza'));
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
              incrementQuest();
            }
          },
          child: const ConfirmButton(text: "continua"),
        ),
      ],
    );
  }

  Widget categoryToAvoidQuest() {
    return BlocProvider(
      create: (_) => _locCatBloc,
      child: BlocListener<LocationCategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationCategoryBloc, LocationcategoryState>(
          builder: (context, state) {
            if (state is LocationcategoryInitial) {
              return const LoadingIndicator();
            } else if (state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationcategoryLoaded) {
              return categoryToAvoidWidget();
            } else if (state is LocationcategoryError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void setCategoryToAvoid() {
    if (CategoryPreference.catSelected.isNotEmpty) {
      mng.filter?.putIfAbsent("locationcategory",
          () => 'nin:' + CategoryPreference.catSelected.join(','));
    }
    //planQuery["avoidCategory"] = CategoryPreference.catSelected;
    incrementQuest();
  }

  Column categoryToAvoidWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            PlannerHeaderCommand(
              count: questNum,
              onCountSelected: () {
                decrementQuest(context);
              },
            ),
            const SizedBox(height: 20),
            ProgressBar(valueProgressIndicator: valueProgressIndicator),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Categorie da evitare ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Mite',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: UIColors.blue)),
                        const TextSpan(text: '?'),
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
            const CategoryPreference()
          ],
        ),
        InkWell(
            onTap: () {
              setCategoryToAvoid();
            },
            child: const ConfirmButton(
              text: "continua",
            )),
      ],
    );
  }

  void setDistanceLocation() {
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

    planQuery["distance"] = _currentSliderValue;
    incrementQuest();
  }

  Widget distanceQuest() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            PlannerHeaderCommand(
              count: questNum,
              onCountSelected: () {
                decrementQuest(context);
              },
            ),
            const SizedBox(height: 20),
            ProgressBar(valueProgressIndicator: valueProgressIndicator),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Quanto lontano ',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Mite',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: UIColors.blue)),
                        const TextSpan(text: '?'),
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
                  child: Text(
                      "Range selezionato " +
                          _currentSliderValue.toString() +
                          " km",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SliderTheme(
              data: SliderThemeData(
                inactiveTickMarkColor: UIColors.grey.withOpacity(0.3),
                activeTickMarkColor: UIColors.black,
                inactiveTrackColor: UIColors.grey.withOpacity(0.3),
                activeTrackColor: UIColors.black,
                thumbColor: UIColors.black,
              ),
              child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 5,
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
          child: const ConfirmButton(text: "continua"),
        ),
      ],
    );
  }

  void setMngCoordinate(double distance) {
    mng.filter?["coordinate.lat"] = '';
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

  Widget selectLocation() {
    return Text("");
    /*
    return BlocProvider(
      create: (_) => _planTripBloc,
      child: BlocListener<PlantripBloc, PlantripState>(
        listener: (context, state) {
          if (state is PlanTripError) {
            SnackBarMessage();
          }
        },
        child: BlocBuilder<PlantripBloc, PlantripState>(
          builder: (context, state) {
            if (state is PlantripInitial) {
              return const LoadingIndicator();
            } else if (state is PlantripLoadingLocation) {
              return const LoadingIndicator();
            } else if (state is PlantripLoadedLocation) {
              return SelectTripLocation(
                //  mng: mng,
                planQuery: planQuery,
                // planTripModel: state.planTripModel,
                goneDate: goneDate,
                returnDate: returnDate,
                //planTripBloc: _planTripBloc,
                locLatitude: locLatitude,
                locLongitude: locLongitude,
                //   backQuest: () => decrementQuest(context),
                context: context,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
 */
  }

  void getCoordinate(String location) async {
    try {
      List<geo.Location> locations = await geo.locationFromAddress(location);

      locLatitude = locations[0].latitude;
      locLongitude = locations[0].longitude;

      incrementQuest();
    } catch (e) {
      _planTripBloc.add(PlanTripErrorEvent(message: 'mess111'));
    }
  }*/
}
