import 'dart:io';
import 'dart:math';

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

  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();

  int questNum = 0;
  double _currentSliderValue = 20;
  Map<String, dynamic> planQuery = {
    "coordinate": {"lat": 0.0, "lng": 0.0, "alt": 0.0},
    "avoidCategory": [],
    "periodAvaiable": [1, 2, 3, 4],
    "dayAvaiable": [1, 2, 3, 4, 5, 6, 7],
    "goneDate": DateTime.now().millisecondsSinceEpoch,
    "returnDate": DateTime.now().millisecondsSinceEpoch,
    "distance": 0,
    "totDay": 1
  };
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
        _planTripBloc.add(GetLocation(body: planQuery.toString(), mng: mng));
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
              mng.filter?.putIfAbsent("goneDate", () => goneDate);
              planQuery["goneDate"] = goneDate.millisecondsSinceEpoch;
            } else {
              returnDate = pickedDate;
              //mng.filter?.putIfAbsent("returnDate", () => returnDate);
              planQuery["returnDate"] = returnDate.millisecondsSinceEpoch;
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

                                  mng.filter
                                      ?.putIfAbsent("goneDate", () => goneDate);
                                  planQuery["goneDate"] =
                                      goneDate.millisecondsSinceEpoch;
                                } else {
                                  returnDate = pickedDate;
                                  //  mng.filter?.putIfAbsent("returnDate", () => returnDate);
                                  planQuery["returnDate"] =
                                      returnDate.millisecondsSinceEpoch;
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
              /*
              planQuery["totDay"] = returnDate.difference(goneDate).inDays;
              planQuery["periodAvaiable"] = getSeason(goneDate.month);
              planQuery["dayAvaiable"] = dayAvaiable;
              */
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
                children: [
                  CategoryPreference(
                    pipeline: '',
                  ),
                  TextButton(
                      onPressed: () {
                        if (CategoryPreference.catSelected.isNotEmpty) {
                          mng.filter?.putIfAbsent(
                              "locationcategory",
                              () =>
                                  'nin:' +
                                  CategoryPreference.catSelected.join(','));
                        }
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
              //mng.filter?.putIfAbsent("distance", () => _currentSliderValue);
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
            child: Text("done"))
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
    planQuery["coordinate"]["lat"] = locations[0].latitude;
    planQuery["coordinate"]["lng"] = locations[0].longitude;
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
      movedPlan.date =
          DateTime.fromMillisecondsSinceEpoch(movedPlan.date ?? 0 * 1000)
              .add(Duration(days: newListIndex))
              .millisecondsSinceEpoch;
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
    List<MovePlanTrip> _locations = [];

    for (Location loc in widget.planTripModel) {
      _locations.add(MovePlanTrip(
          locationId: loc.iId, date: widget.goneDate.microsecondsSinceEpoch));
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
        planList.add(el.encode());
      }
    }

    widget.planQuery["trip"] = [planList.join(",")];
    widget.planTripBloc
        .add(SaveTrip(body: widget.planQuery.toString(), mng: widget.mng));
  }
}
