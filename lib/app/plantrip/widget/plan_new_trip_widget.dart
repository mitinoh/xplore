import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:xplore/model/coordinate_model.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/move_plan_trip_model.dart';

class NetTripQuestion extends StatefulWidget {
  const NetTripQuestion({Key? key}) : super(key: key);
  // https://pub.dev/packages/drag_and_drop_lists

  @override
  State<NetTripQuestion> createState() => _NetTripQuestionState();
}

class _NetTripQuestionState extends State<NetTripQuestion> {
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  final PlantripBloc _planTripBloc = PlantripBloc();

  DateTime goneDate = DateUtils.dateOnly(DateTime.now());
  DateTime returnDate = DateUtils.dateOnly(DateTime.now());

  int questNum = 0;
  double valueProgressIndicator = 0.25;
  double _currentSliderValue = 20;
  Map<String, dynamic> planQuery = {};
  Mongoose mng = Mongoose(filter: {}, select: {}, sort: {});

  double locLatitude = 0;
  double locLongitude = 0;
  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  void incrementQuest() {
    setState(() {
      questNum++;
      valueProgressIndicator += 0.25;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (questNum) {
      case 0:
        return whereToGoQuest();
      case 1:
        return periodToGoQuest();
      case 2:
        return categoryToAvoidQuest();
      case 3:
        return distanceQuest();
      case 4:
        return tripNameQuest();
      case 5:
        return showTrip();
      case 6:
        _planTripBloc
            .add(GetLocation(/*body: planQuery.toString(),*/ mng: mng));
        return selectLocation();
      default:
        return Scaffold(
          body: SafeArea(
            child: Container(),
          ),
        );
    }
  }

  Widget tripNameQuest() {
    final TextEditingController _nameController = TextEditingController();
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          //  decoration: InputDecoration(border: InputBorder.none),
        ),
        TextButton(
          onPressed: () {
            planQuery.putIfAbsent("tripName", () => _nameController.text);
            print(_nameController.text);
            incrementQuest();
          },
          child: Text(questNum.toString()),
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
        Flexible(
          flex: 1,
          child: Row(
            children: const [Icon(Iconsax.close_square)],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Dove vorresti andare ',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Mite',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: UIColors.violet)),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
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
                    suffixIconColor: UIColors.violet,
                    prefixIcon: Icon(
                      Iconsax.driving,
                      color: UIColors.violet,
                    ),
                  ),
                  autofocus: false,
                ),
              ))
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () => {
              getCoordinate(_nameController.text.toString()),
              incrementQuest()
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.lightGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continua".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Iconsax.arrow_right_1,
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: valueProgressIndicator,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(UIColors.violet),
                  backgroundColor: UIColors.violet.withOpacity(0.2),
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget periodToGoQuest() {
    //Method for showing the date picker
    void _pickDateDialog(bool gone) {
      // quardare https://pub.dev/packages/flutter_cupertino_date_picker#-readme-tab-
      if (Platform.isAndroid) {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime
                    .now()) //what will be the up to supported date in picker
            .then((pickedDate) {
          //then usually do the future job
          if (pickedDate == null) {
            //if user tap cancel then this function will stop
            return;
          }
          setState(() {
            //for rebuilding the ui
            if (gone) {
              goneDate = DateUtils.dateOnly(pickedDate);
              mng.filter?.putIfAbsent("goneDate", () => goneDate);
              //planQuery["goneDate"] = goneDate.millisecondsSinceEpoch;
            } else {
              returnDate = DateUtils.dateOnly(pickedDate);
              //mng.filter?.putIfAbsent("returnDate", () => returnDate);
              //planQuery["returnDate"] = returnDate.millisecondsSinceEpoch;
            }
          });
        });
      } else if (Platform.isIOS) {
        showCupertinoModalPopup(
            context: context,
            builder: (_) => Container(
                  height: 400,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: CupertinoDatePicker(
                            minimumDate: DateTime.now(),
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (pickedDate) {
                              setState(() {
                                if (gone) {
                                  goneDate = DateUtils.dateOnly(pickedDate);

                                  mng.filter
                                      ?.putIfAbsent("goneDate", () => goneDate);
                                  // planQuery["goneDate"] = goneDate.millisecondsSinceEpoch;
                                } else {
                                  returnDate = DateUtils.dateOnly(pickedDate);
                                  //  mng.filter?.putIfAbsent("returnDate", () => returnDate);
                                  // planQuery["returnDate"] =  returnDate.millisecondsSinceEpoch;
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ));
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: const [Icon(Iconsax.close_square)],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Quando vorresti partire ',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Mite',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: UIColors.violet)),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () => {_pickDateDialog(true)},
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.grey.withOpacity(0.3),
              ),
              child: Text(
                "Data di partenza".toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () => {_pickDateDialog(false)},
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.grey.withOpacity(0.3),
              ),
              child: Text(
                "Data di ritorno".toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              List<int> dayAvaiable = [];
              // FIXME: ovvio che cosi non funziona porca troia

              for (int i = goneDate.weekday; i < returnDate.weekday; i++) {
                dayAvaiable.add(i);
              }
              /*
              planQuery["totDay"] = returnDate.difference(goneDate).inDays;
              planQuery["periodAvaiable"] = getSeason(goneDate.month);
              planQuery["dayAvaiable"] = dayAvaiable;
              */
              incrementQuest();
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.lightGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continua".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Iconsax.arrow_right_1,
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: valueProgressIndicator,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(UIColors.violet),
                  backgroundColor: UIColors.violet.withOpacity(0.2),
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryToAvoidQuest() {
    return BlocProvider(
      create: (_) => _locCatBloc,
      child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationcategoryBloc, LocationcategoryState>(
          builder: (context, state) {
            if (state is LocationcategoryInitial) {
              return LoadingIndicator();
            } else if (state is LocationCategoryLoading) {
              return LoadingIndicator();
            } else if (state is LocationcategoryLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: const [Icon(Iconsax.close_square)],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Categorie da evitare ',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Mite',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: UIColors.violet)),
                                const TextSpan(text: '?'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CategoryPreference(
                  ),
                  Flexible(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        if (CategoryPreference.catSelected.isNotEmpty) {
                          mng.filter?.putIfAbsent(
                              "locationcategory",
                              () =>
                                  'nin:' +
                                  CategoryPreference.catSelected.join(','));
                        }
                        //planQuery["avoidCategory"] = CategoryPreference.catSelected;
                        incrementQuest();
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: UIColors.lightGreen,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continua".toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Iconsax.arrow_right_1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: valueProgressIndicator,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(UIColors.violet),
                            backgroundColor: UIColors.violet.withOpacity(0.2),
                            semanticsLabel: 'Linear progress indicator',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
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

  Widget distanceQuest() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: const [Icon(Iconsax.close_square)],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Quanto lontano ',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Mite',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: UIColors.violet)),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 100,
          divisions: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              double latDis = getLatDis(_currentSliderValue);
              double lngDis = getLngDis(_currentSliderValue, latDis);
              mng.filter?["coordinate.lat=lte:" +
                  (locLatitude + latDis).toString()] = null;
              mng.filter?["coordinate.lat=gte:" +
                  (locLatitude - latDis).toString()] = null;

              mng.filter?["coordinate.lng=lte:" +
                  (locLongitude + lngDis).toString()] = null;

              mng.filter?["coordinate.lng=gte:" +
                  (locLongitude - lngDis).toString()] = null;

              planQuery["distance"] = _currentSliderValue;
              incrementQuest();
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: UIColors.lightGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continua".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Iconsax.arrow_right_1,
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: valueProgressIndicator,
                  valueColor: AlwaysStoppedAnimation<Color>(UIColors.violet),
                  backgroundColor: UIColors.violet.withOpacity(0.2),
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  setMngCoordinate(double distance) {
    mng.filter?["coordinate.lat"] = '';
  }

  double getLatDis(double dis) {
    return dis / 110.574;
  }

  double getLngDis(double dis, double lat) {
    return dis / (111.320 * cos(lat));
  }

  Widget showTrip() {
    return TextButton(
        onPressed: () {
          incrementQuest();
        },
        child: Text("asd"));
  }

  int getSeason(int month) {
    if (month == 8 || month == 10 || month == 11) return 0;
    if (month == 12 || month == 1 || month == 2) return 1;
    if (month == 3 || month == 4 || month == 5) return 2;
    return 3;
  }

// restituisce tutte le location possibili
  Widget selectLocation() {
    return BlocProvider(
      create: (_) => _planTripBloc,
      child: BlocListener<PlantripBloc, PlantripState>(
        listener: (context, state) {
          if (state is PlanTripError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<PlantripBloc, PlantripState>(
          builder: (context, state) {
            if (state is PlantripInitial) {
              return LoadingIndicator();
            } else if (state is PlantripLoadingLocation) {
              return LoadingIndicator();
            } else if (state is PlantripLoadedLocation) {
              return SelectTripLocation(
                mng: mng,
                planQuery: planQuery,
                planTripModel: state.planTripModel,
                goneDate: goneDate,
                returnDate: returnDate,
                planTripBloc: _planTripBloc,
                locLatitude: locLatitude,
                locLongitude: locLongitude,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void getCoordinate(String location) async {
    List<geo.Location> locations = await geo.locationFromAddress(location);
    locLatitude = locations[0].latitude;
    locLongitude = locations[0].longitude;

/*
    mng.filter?.putIfAbsent(
        "coordinate.lat", () => 'lte:' + locations[0].latitude.toString());
    mng.filter?.putIfAbsent(
        "coordinate.lng", () => 'lte:' + locations[0].longitude.toString());
        */
    // planQuery["coordinate"]["lat"] = locations[0].latitude;
    // planQuery["coordinate"]["lng"] = locations[0].longitude;
  }
}

class SelectTripLocation extends StatefulWidget {
  SelectTripLocation(
      {Key? key,
      required this.mng,
      required this.planQuery,
      required this.planTripModel,
      required this.goneDate,
      required this.returnDate,
      required this.planTripBloc,
      required this.locLatitude,
      required this.locLongitude})
      : super(key: key);
  Mongoose mng = Mongoose();
  Map<String, dynamic> planQuery = {};
  List<Location> planTripModel = [];
  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  PlantripBloc planTripBloc = PlantripBloc();
  double locLatitude = 0;
  double locLongitude = 0;

  @override
  State<SelectTripLocation> createState() => _SelectTripLocationState();
}

class _SelectTripLocationState extends State<SelectTripLocation> {
  List<DragAndDropList> _contents = [];
  List<List<MovePlanTrip>> _plan = [];

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      MovePlanTrip movedPlan = _plan[oldListIndex][oldItemIndex];
      movedPlan.date = movedPlan.date?.add(Duration(days: newListIndex));
      /*
      DateTime.fromMillisecondsSinceEpoch(movedPlan.date ?? 0 * 1000)
          .add(Duration(days: newListIndex))
          .millisecondsSinceEpoch;
          */
      _plan[oldListIndex].removeAt(oldItemIndex);
      _plan[newListIndex].insert(newItemIndex, movedPlan);
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  @override
  void initState() {
    super.initState();
    int tripDay = widget.returnDate.difference(widget.goneDate).inDays + 1;
    tripDay = tripDay > 0 ? tripDay : 1;

    List<DragAndDropItem> _dragLocation = [];
    List<MovePlanTrip> _locations = [];

    for (Location loc in widget.planTripModel) {
      _locations.add(MovePlanTrip(locationId: loc.iId, date: widget.goneDate));
      _dragLocation.add(DragAndDropItem(
        child: Text(loc.iId ?? ''),
      ));
    }

    _contents = List.generate(tripDay, (index) {
      return DragAndDropList(
        header: Text(widget.goneDate.add(Duration(days: index)).toString()),
        children: index == 0 ? _dragLocation : <DragAndDropItem>[],
      );
    });

    _plan.add(_locations);

    for (var i = 0; i < tripDay; i++) {
      _plan.add([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              saveTripPlan();
            },
            child: Text("done")),
        Container(
          height: 500,
          child: DragAndDropLists(
            children: _contents,
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
          ),
        )
      ],
    );
  }

  saveTripPlan() {
    List planList = [];
    for (List fl in _plan) {
      for (MovePlanTrip el in fl) {
        // salvo solamente i gg in cui c'è un attivita

        planList.add(el.toJson());
      }
    }

    widget.planQuery
        .putIfAbsent("goneDate", () => widget.goneDate.toIso8601String());
    widget.planQuery
        .putIfAbsent("returnDate", () => widget.returnDate.toIso8601String());
    widget.planQuery.putIfAbsent("plannedLocation", () => planList);
    widget.planQuery.putIfAbsent(
        "coordinate",
        () =>
            {"lat": widget.locLatitude, "lng": widget.locLongitude, "alt": 0});

    widget.planQuery.putIfAbsent(
        "avoidCategory",
        () => widget.mng.filter?["locationcategory"]
            .toString()
            .substring(4)
            .split(','));
    print(widget.planQuery["avoidCategory"]);

    //widget.planQuery["trip"] = [planList.join(",")];
    widget.planTripBloc.add(SaveTrip(body: widget.planQuery));
  }
}
