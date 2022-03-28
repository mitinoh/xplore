import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/plantrip/repository/plan_trip_repository.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:geocoding/geocoding.dart' as geo;

class NetTripQuestion extends StatefulWidget {
  const NetTripQuestion({Key? key}) : super(key: key);

  @override
  State<NetTripQuestion> createState() => _NetTripQuestionState();
}

class _NetTripQuestionState extends State<NetTripQuestion> {
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();
  int questNum = 0;
  double _currentSliderValue = 20;
  Map<String, dynamic> planQuery = {
    "lat": 0.0,
    "lng": 0.0,
    "avoidCategory": [],
    "periodAvaiable": [1, 2, 3, 4],
    "dayAvaiable": [1, 2, 3, 4, 5, 6, 7],
    /* "goneDate": DateTime.now(),
    "returnDate": DateTime.now(),*/
    "distance": 0
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
        PlanTripRepository().fetchLocationList(body: planQuery.toString());

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
    DateTime goneDay = DateTime.now();
    DateTime returnDay = DateTime.now();
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
              goneDay = pickedDate;
            } else {
              returnDay = pickedDate;
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
                                  goneDay = pickedDate;
                                } else {
                                  returnDay = pickedDate;
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
              for (int i = goneDay.weekday; i < returnDay.weekday; i++) {
                dayAvaiable.add(i);
              }

              planQuery["periodAvaiable"] = getSeason(goneDay.month);
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

  Widget selectLocation() {
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
              return Text(state.locationCategoryModel.toString());
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

  void getCoordinate(String location) async {
    List<geo.Location> locations = await geo.locationFromAddress(location);

    planQuery["lat"] = locations[0].latitude;
    planQuery["lng"] = locations[0].longitude;
  }
}
