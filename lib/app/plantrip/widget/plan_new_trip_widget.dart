import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/widget/select_trip_location_widget.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:xplore/model/mongoose_model.dart';

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
  Mongoose mng = Mongoose(filter: {}, select: [], sort: {});

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
          style: const TextStyle(color: Colors.black),
          //  decoration: InputDecoration(border: InputBorder.none),
        ),
        TextButton(
          onPressed: () {
            planQuery.putIfAbsent("tripName", () => _nameController.text);
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
                  valueColor: AlwaysStoppedAnimation<Color>(UIColors.violet),
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
        setTripDate(gone, pickedDate);
      });
    } else if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
                height: 400,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: CupertinoDatePicker(
                          minimumDate: DateTime.now(),
                          initialDateTime: DateTime.now(),
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
              // FIXME
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
        const CategoryPreference(),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              setCategoryToAvoid();
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
              setDistanceLocation();
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
              return const LoadingIndicator();
            } else if (state is PlantripLoadingLocation) {
              return const LoadingIndicator();
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
