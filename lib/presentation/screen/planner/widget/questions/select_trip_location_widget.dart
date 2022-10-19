import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xplore/data/api/mongoose.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/move_planner_model.dart';
import 'package:xplore/data/model/trip_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';
import 'package:xplore/presentation/common_widgets/wg_circle_image.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:xplore/utils/imager.dart';
import '../../bloc_question/bloc.dart';

class SelectTripLocation extends StatefulWidget {
  SelectTripLocation({
    Key? key,
  }) : super(key: key);
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
  List<LocationCategoryModel> avoidCategory = [];

  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  final List<List<MovePlannerModel>> _plan = [];
  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      MovePlannerModel movedPlan = _plan[oldListIndex][oldItemIndex];
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
    latitude = BlocProvider.of<PlannerQuestionBloc>(context)
            .planTripQuestions
            .geometry
            ?.coordinates?[1] ??
        0;
    longitude = BlocProvider.of<PlannerQuestionBloc>(context)
            .planTripQuestions
            .geometry
            ?.coordinates?[0] ??
        0;
    distance =
        BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.distance ?? 0;
    tripName =
        BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.tripName ?? '';
    goneDate = BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.goneDate ??
        DateTime.now();
    returnDate = context.read<PlannerQuestionBloc>().planTripQuestions.returnDate ??
        DateTime.now();


    avoidCategory =
        context.read<PlannerQuestionBloc>().planTripQuestions.avoidCategory ?? [];

    mng.filter?.add(Filter(key: "latitude", operation: "=", value: latitude.toString()));
    mng.filter
        ?.add(Filter(key: "longitude", operation: "=", value: longitude.toString()));
    mng.filter?.add(Filter(key: "distance", operation: "=", value: distance.toString()));

    mng.filter?.add(Filter(
        key: "locationCategory",
        operation: "!=",
        value: avoidCategory.map((category) => category.id).toList().join(',')));

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
  List<MovePlannerModel> _locations = [];

  late ThemeData themex;

  @override
  void initState() {
    Mongoose query = getQuery();
    context.read<PlannerQuestionBloc>().add(PlannerGetLocation(mng: query));
    _buildCard();
    super.initState();
  }

  _buildCard() {
    int tripDay =
        DateUtils.dateOnly(returnDate).difference(DateUtils.dateOnly(goneDate)).inDays +
            1;
    tripDay = tripDay > 0 ? tripDay : 1;

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    _contents = List.generate(tripDay + 1, (index) {
      return DragAndDropList(
        contentsWhenEmpty: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 0, bottom: 0, top: 10),
          child: Text(
              index == 0
                  ? "There are no places or events"
                  : "You have not scheduled any activities for this day. Drag an activity in here!",
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
        ),
        decoration: BoxDecoration(
            //color: UIColors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        canDrag: false,
        header: Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0, bottom: 10, top: 0),
          child: RichText(
            text: TextSpan(
              text: index == 0
                  ? 'Here is what we found that might interest you, drag the place/event you are interested in to the day you would like to visit it..'
                  : 'Day ',
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w300, color: Colors.grey),
              children: <TextSpan>[
                TextSpan(
                    text: index == 0
                        ? ''
                        : formatter
                            .format(goneDate.add(Duration(days: index)))
                            .toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey)),
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
    themex = Theme.of(context);
    return BlocProvider.value(
      value: BlocProvider.of<PlannerQuestionBloc>(context),
      child: BlocListener<PlannerQuestionBloc, PlannerQuestionState>(
        listener: (context, state) {
          if (state is PlannerError) {
            SbError().show(context);
          }
        },
        child: BlocBuilder<PlannerQuestionBloc, PlannerQuestionState>(
          builder: (context, state) {
            if (state is PlannerQuestionInitial) {
              return const LoadingIndicator();
            } else if (state is PlannerQuestionLocationsLoaded) {
              for (LocationModel loc in state.locations) {
                if (firstLoad) {
                  _locations.add(MovePlannerModel(locationId: loc.id, date: goneDate));
                  firstLoad = false;

                  _dragLocation.add(DragAndDropItem(
                    child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 0, right: 0),
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: themex.cardColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (() {
                                _buildlocationDetailModalBottomSheet(loc);
                              }),
                              child: CircleImageWidget(
                                imageUrl: Img.getLocationUrl(loc),
                                radius: 20,
                              ),
                            ),
                            InkWell(
                                onTap: (() {
                                  _buildlocationDetailModalBottomSheet(loc);
                                }),
                                child: Expanded(
                                  child: Text(
                                    loc.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: themex.indicatorColor,
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0, left: 15),
                              child: Icon(
                                Icons.drag_handle,
                                color: themex.indicatorColor,
                              ),
                            ),
                          ],
                        )),
                  ));
                }
              }
              return mainWidget();
            } else {
              return ErrorScreen(state: state);
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
            BlocProvider.of<PlannerQuestionBloc>(context).add(PlannerEndQuestion())
          },
          child: ConfirmButton(
              text: "We finished",
              colors: themex.primaryColor,
              colorsText: themex.canvasColor),
        ),
      ],
    );
  }

  saveTripPlan() {
    List<TripModel> planList = [];
    for (List fl in _plan) {
      for (MovePlannerModel el in fl) {
        // salvo solamente i gg in cui c'è un attivita
        TripModel tm =
            TripModel(date: el.date, location: LocationModel(id: el.locationId ?? ''));
        planList.add(tm);
      }
    }

    BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions.plannedLocation =
        planList;
    BlocProvider.of<PlannerQuestionBloc>(context).add(SaveTrip(
        newTrip: BlocProvider.of<PlannerQuestionBloc>(context).planTripQuestions));
  }

  void _buildlocationDetailModalBottomSheet(LocationModel location) {
    DetailLocationModal(location: location).show(context);
  }
}
