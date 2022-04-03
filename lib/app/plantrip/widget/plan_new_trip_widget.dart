import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:xplore/model/location_model.dart';

class NetTripQuestion extends StatefulWidget {
  const NetTripQuestion({Key? key}) : super(key: key);
  // https://pub.dev/packages/drag_and_drop_lists

  @override
  State<NetTripQuestion> createState() => _NetTripQuestionState();
}

class _NetTripQuestionState extends State<NetTripQuestion> {
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  final PlantripBloc _planTripBloc = PlantripBloc();

  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  int questNum = 0;
  double _currentSliderValue = 20;
  Map<String, dynamic> planQuery = {
    "lat": 0.0,
    "lng": 0.0,
    "avoidCategory": [],
    "periodAvaiable": [1, 2, 3, 4],
    "dayAvaiable": [1, 2, 3, 4, 5, 6, 7],
    //"goneDate": DateTime.now().toIso8601String(),
    //"returnDate": DateTime.now().toIso8601String(),
    "distance": 0,
    "totDay": 1
  };

  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  void incrementQuest() {
    setState(() {
      questNum++;
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
        return showTrip();
      case 5:
        _planTripBloc.add(GetLocation(body: planQuery.toString()));
        return selectLocation();
      default:
        return Scaffold(
          body: SafeArea(
            child: Container(),
          ),
        );
    }
  }

  Widget whereToGoQuest() {
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
            getCoordinate(_nameController.text.toString());
            incrementQuest();
          },
          child: Text(questNum.toString()),
        ),
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
              goneDate = pickedDate;
              planQuery["goneDate"] = goneDate.toIso8601String();
            } else {
              returnDate = pickedDate;
              planQuery["returnDate"] = returnDate.toIso8601String();
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
                                  goneDate = pickedDate;
                                  // FIXME
                                  /* planQuery["goneDate"] = "new Date('" +
                                      goneDate.toIso8601String() +
                                      "')";*/
                                } else {
                                  returnDate = pickedDate;
                                  // FIXME
                                  /*  planQuery["returnDate"] = "new Date('" +
                                      returnDate.toIso8601String() +
                                      "')";
                                      */
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
      children: [
        RaisedButton(
            child: Text('Gone Date'),
            onPressed: () {
              _pickDateDialog(true);
            }),
        RaisedButton(
            child: Text('Return Date'),
            onPressed: () {
              _pickDateDialog(false);
            }),
        RaisedButton(
            child: Text('Next'),
            onPressed: () {
              List<int> dayAvaiable = [];
              // FIXME: ovvio che cosi non funziona porca troia

              for (int i = goneDate.weekday; i < returnDate.weekday; i++) {
                dayAvaiable.add(i);
              }
              planQuery["totDay"] = returnDate.difference(goneDate).inDays;
              planQuery["periodAvaiable"] = getSeason(goneDate.month);
              planQuery["dayAvaiable"] = dayAvaiable;
              incrementQuest();
            }),
      ],
    );
  }

  Widget categoryToAvoidQuest() {
    return BlocProvider(
      create: (_) => _locCatBloc,
      child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is HomeError) {
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
                children: [
                  CategoryPreference(
                    pipeline: '',
                  ),
                  TextButton(
                      onPressed: () {
                        planQuery["avoidCategory"] =
                            CategoryPreference.catSelected;
                        incrementQuest();
                      },
                      child: Text("done"))
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
      children: [
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
        TextButton(
            onPressed: () {
              planQuery["distance"] = _currentSliderValue;
              incrementQuest();
            },
            child: Text("done"))
      ],
    );
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
                planQuery: planQuery,
                planTripModel: state.planTripModel,
                goneDate: goneDate,
                returnDate: returnDate,
                planTripBloc: _planTripBloc,
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

    planQuery["lat"] = locations[0].latitude;
    planQuery["lng"] = locations[0].longitude;
  }
}

class SelectTripLocation extends StatefulWidget {
  SelectTripLocation(
      {Key? key,
      required this.planQuery,
      required this.planTripModel,
      required this.goneDate,
      required this.returnDate,
      required this.planTripBloc})
      : super(key: key);
  Map<String, dynamic> planQuery = {};
  List<Location> planTripModel = [];
  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  PlantripBloc planTripBloc = PlantripBloc();

  @override
  State<SelectTripLocation> createState() => _SelectTripLocationState();
}

class _SelectTripLocationState extends State<SelectTripLocation> {
  List<DragAndDropList> _contents = [];
  List<List<String>> _plan = [];

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      String movedPlan = _plan[oldListIndex][oldItemIndex];
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
    int tripDay = int.tryParse(widget.planQuery["totDay"].toString()) ?? 1;
    tripDay = tripDay > 0 ? tripDay : 1;

    List<DragAndDropItem> _dragLocation = [];
    List<String> _locations = [];

    for (Location loc in widget.planTripModel) {
      _locations.add(loc.iId?.oid ?? '');
      _dragLocation.add(DragAndDropItem(
        child: Text(loc.iId?.oid ?? ''),
      ));
    }

    _contents = List.generate(tripDay, (index) {
      return DragAndDropList(
        header: Text(widget.goneDate.add(Duration(days: index)).toString()),
        children: index == 0 ? _dragLocation : <DragAndDropItem>[],
      );
    });

    _plan = List.generate(tripDay, (index) {
      return index == 0 ? _locations : [];
    });
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
    // TODO: aggiungere anche le date di inizio e fine
    log(json.encode(_plan));
    String planStr = json.encode(_plan);
    widget.planTripBloc.add(SaveTrip(body: "{trip: $planStr}"));
  }
}
