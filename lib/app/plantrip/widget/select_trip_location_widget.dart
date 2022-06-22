import 'dart:math';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/move_plan_trip_model.dart';

class SelectTripLocation extends StatefulWidget {
  SelectTripLocation(
      {Key? key,
      //required this.mng,
      //required this.planQuery,
      // required this.planTripModel,
      // required this.goneDate,
      // required this.returnDate,
      // required this.locLatitude,
      //required this.locLongitude,
      //  required this.backQuest,
      required this.context})
      : super(key: key);
  // // Mongoose mng = Mongoose();
  // Map<String, dynamic> planQuery = {};
  // List<LocationModel> planTripModel = [];
  // DateTime goneDate = DateTime.now();
  // DateTime returnDate = DateTime.now();
  // double locLatitude = 0;
  // double locLongitude = 0;
  BuildContext context;
  // final VoidCallback backQuest;

  @override
  State<SelectTripLocation> createState() => _SelectTripLocationState();
}

class _SelectTripLocationState extends State<SelectTripLocation> {
  List<DragAndDropList> _contents = [];
  String tripName = "";

  double latitude = 0;
  double longitude = 0;
  double distance = 0;
  bool firstLoad = true;
  List<String> avoidCategory = [];

  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  final List<List<MovePlanTripModel>> _plan = [];
  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      MovePlanTripModel movedPlan = _plan[oldListIndex][oldItemIndex];
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

  void setMngCoordinate(double distance) {
    // mng.filter?["coordinate.lat"] = '';
  }

  double getLatDis(double dis) {
    return dis / 110.574;
  }

  double getLngDis(double dis, double lat) {
    return dis / (111.320 * cos(lat));
  }

  Mongoose getQuery() {
    Mongoose mng = Mongoose(filter: []);
    latitude = context.read<PlantripBloc>().planTripQuestionsMap["latitude"];
    longitude = context.read<PlantripBloc>().planTripQuestionsMap["longitude"];
    distance = context.read<PlantripBloc>().planTripQuestionsMap["distance"];
    tripName = context.read<PlantripBloc>().planTripQuestionsMap["tripName"];
    goneDate = context.read<PlantripBloc>().planTripQuestionsMap["goneDate"];
    returnDate =
        context.read<PlantripBloc>().planTripQuestionsMap["returnDate"];
    if (context.read<PlantripBloc>().planTripQuestionsMap["avoidCategory"] !=
        null) {
      avoidCategory = context
          .read<PlantripBloc>()
          .planTripQuestionsMap["avoidCategory"]
          .split(',');
    }

    mng.filter?.add(
        Filter(key: "latitude", operation: "=", value: latitude.toString()));
    mng.filter?.add(
        Filter(key: "longitude", operation: "=", value: longitude.toString()));
    mng.filter?.add(
        Filter(key: "distance", operation: "=", value: distance.toString()));
    mng.filter?.add(Filter(
        key: "locationCategory",
        operation: "!=",
        value: avoidCategory.join(',')));

/*
    double latDis = getLatDis(distance);
    double lngDis = getLngDis(distance, latDis);
    mng.filter?["coordinate.lat=lte:" + (latitude + latDis).toString()] = null;
    mng.filter?["coordinate.lat=gte:" + (latitude - latDis).toString()] = null;
    mng.filter?["coordinate.lng=lte:" + (longitude + lngDis).toString()] = null;
    mng.filter?["coordinate.lng=gte:" + (longitude - lngDis).toString()] = null;
    */
    return mng;
  }

  List<DragAndDropItem> _dragLocation = [];
  List<MovePlanTripModel> _locations = [];

  @override
  void initState() {
    Mongoose query = getQuery();
    context.read<PlantripBloc>().add(GetLocation(mng: query));
    super.initState();
    int tripDay = DateUtils.dateOnly(returnDate)
            .difference(DateUtils.dateOnly(goneDate))
            .inDays +
        1;
    tripDay = tripDay > 0 ? tripDay : 1;

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    _contents = List.generate(tripDay + 1, (index) {
      return DragAndDropList(
        contentsWhenEmpty: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 10),
          child: Text(
              index == 0
                  ? "Non ci sono più posti disponibili"
                  : "Per questo giorno non hai programmato nessuna attività. Trascina un attività qua dentro!",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
        ),
        decoration: BoxDecoration(
            color: UIColors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        canDrag: false,
        header: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 20),
          child: RichText(
            text: TextSpan(
              text: index == 0
                  ? 'Ecco la lista di tutti i posti che abbiamo trovato.'
                  : 'Giorno ',
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: index == 0
                        ? ''
                        : formatter
                            .format(goneDate.add(Duration(days: index)))
                            .toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ],
            ),
          ),
        ),
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
    return BlocProvider.value(
      value: BlocProvider.of<PlantripBloc>(context),
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
              for (LocationModel loc in state.planTripModel) {
                if (firstLoad) {
                  _locations.add(
                      MovePlanTripModel(locationId: loc.iId, date: goneDate));
                  firstLoad = false;

                  _dragLocation.add(DragAndDropItem(
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 20, right: 20),
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: UIColors.grey.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: UIColors.blue,
                              backgroundImage: const NetworkImage(
                                  'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
                            ),
                            Expanded(
                              child: Text(
                                loc.name ?? '',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0, left: 15),
                              child: Icon(
                                Icons.drag_handle,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ));
                }
              }
              return mainWidget();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  mainWidget() {
    var mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: mediaQuery.size.height * 0.55,
              child: DragAndDropLists(
                listDivider: const SizedBox(height: 5),
                children: _contents,
                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
              ),
            )
          ],
        ),
        InkWell(
          onTap: () => {
            saveTripPlan(),
            BlocProvider.of<PlantripBloc>(widget.context)
                .add(PlanTripEndQuestion())
          },
          child: const ConfirmButton(text: "Abbiamo finito"),
        ),
      ],
    );
  }

  saveTripPlan() {
    List planList = [];
    for (List fl in _plan) {
      for (MovePlanTripModel el in fl) {
        // salvo solamente i gg in cui c'è un attivita

        planList.add(el.toJson());
      }
    }

    Map<String, dynamic> planQuery = {};
    planQuery["goneDate"] = goneDate.toIso8601String();
    planQuery["returnDate"] = returnDate.toIso8601String();
    planQuery["plannedLocation"] = planList;
    planQuery["tripName"] = tripName;
    planQuery["distance"] = distance;
    planQuery["coordinate"] = {"lat": latitude, "lng": longitude, "alt": 0};
    planQuery["avoidCategory"] = avoidCategory;
    BlocProvider.of<PlantripBloc>(widget.context)
        .add(SaveTrip(body: planQuery));
/*
    widget.planQuery
        .putIfAbsent("goneDate", () => widget.goneDate.toIso8601String());
    widget.planQuery
        .putIfAbsent("returnDate", () => widget.returnDate.toIso8601String());
    widget.planQuery.putIfAbsent("plannedLocation", () => planList);
    widget.planQuery.putIfAbsent(
        "coordinate",
        () =>
            {"lat": widget.locLatitude, "lng": widget.locLongitude, "alt": 0});
            */
/*
    widget.planQuery.putIfAbsent(
        "avoidCategory",
        () => widget.mng.filter?["locationcategory"]
            .toString()
            .substring(4)
            .split(','));
*/
    //widget.planQuery["trip"] = [planList.join(",")];
    /*
    BlocProvider.of<PlantripBloc>(widget.context)
        .add(SaveTrip(body: widget.planQuery));*/
  }
}
