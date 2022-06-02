import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/move_plan_trip_model.dart';

import 'close_button.dart';

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
  List<LocationModel> planTripModel = [];
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
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            padding:
                const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: UIColors.grey.withOpacity(0.3),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15),
                  child: Icon(
                    Icons.drag_handle,
                    color: UIColors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CircleAvatar(),
                ),
                Text(
                  loc.name ?? '',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ],
            )),
      ));
    }

    _contents = List.generate(tripDay, (index) {
      return DragAndDropList(
        canDrag: false,
        header: Text(
          "Giorni: " + widget.goneDate.add(Duration(days: index)).toString(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
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
    var mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: const [CloseButtonUI()],
            ),
            const SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 100,
                    valueColor: AlwaysStoppedAnimation<Color>(UIColors.blue),
                    backgroundColor: UIColors.blue.withOpacity(0.2),
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
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
              height: mediaQuery.size.height * 0.45,
              child: DragAndDropLists(
                children: _contents,
                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
              ),
            )
          ],
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () => {saveTripPlan()},
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
                    "Fatto".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
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

    widget.planQuery.putIfAbsent(
        "avoidCategory",
        () => widget.mng.filter?["locationcategory"]
            .toString()
            .substring(4)
            .split(','));

    //widget.planQuery["trip"] = [planList.join(",")];
    widget.planTripBloc.add(SaveTrip(body: widget.planQuery));
  }
}
