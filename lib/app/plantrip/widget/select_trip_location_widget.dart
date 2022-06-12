import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/progressbar.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/move_plan_trip_model.dart';

import 'planner_header_commands.dart';

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
  // Mongoose mng = Mongoose();
  Map<String, dynamic> planQuery = {};
  List<LocationModel> planTripModel = [];
  DateTime goneDate = DateTime.now();
  DateTime returnDate = DateTime.now();
  double locLatitude = 0;
  double locLongitude = 0;
  BuildContext context;
  // final VoidCallback backQuest;

  @override
  State<SelectTripLocation> createState() => _SelectTripLocationState();
}

class _SelectTripLocationState extends State<SelectTripLocation> {
  List<DragAndDropList> _contents = [];
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

  @override
  void initState() {
    context
        .read<PlantripBloc>()
        .add(GetLocation(mng: Mongoose(filter: {}, select: [], sort: {})));
    super.initState();
    int tripDay = widget.returnDate.difference(widget.goneDate).inDays + 1;
    tripDay = tripDay > 0 ? tripDay : 1;

    List<DragAndDropItem> _dragLocation = [];
    List<MovePlanTripModel> _locations = [];

    for (LocationModel loc in widget.planTripModel) {
      _locations
          .add(MovePlanTripModel(locationId: loc.iId, date: widget.goneDate));
      _dragLocation.add(DragAndDropItem(
        child: Container(
            margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
            padding:
                const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: UIColors.grey.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15.0, left: 15),
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.black,
                  ),
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
                CircleAvatar(
                  backgroundColor: UIColors.blue,
                  backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
                ),
              ],
            )),
      ));
    }
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    _contents = List.generate(tripDay, (index) {
      return DragAndDropList(
        contentsWhenEmpty: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
              "Per questo giorno non hai programmato nessuna attività. Trascina un attività qua dentro!",
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
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            text: TextSpan(
              text: 'Giorno ',
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: formatter
                        .format(widget.goneDate.add(Duration(days: index)))
                        .toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
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
            SizedBox(
              height: mediaQuery.size.height * 0.35,
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

    widget.planQuery
        .putIfAbsent("goneDate", () => widget.goneDate.toIso8601String());
    widget.planQuery
        .putIfAbsent("returnDate", () => widget.returnDate.toIso8601String());
    widget.planQuery.putIfAbsent("plannedLocation", () => planList);
    widget.planQuery.putIfAbsent(
        "coordinate",
        () =>
            {"lat": widget.locLatitude, "lng": widget.locLongitude, "alt": 0});
/*
    widget.planQuery.putIfAbsent(
        "avoidCategory",
        () => widget.mng.filter?["locationcategory"]
            .toString()
            .substring(4)
            .split(','));
*/
    //widget.planQuery["trip"] = [planList.join(",")];
    BlocProvider.of<PlantripBloc>(widget.context)
        .add(SaveTrip(body: widget.planQuery));
  }
}
