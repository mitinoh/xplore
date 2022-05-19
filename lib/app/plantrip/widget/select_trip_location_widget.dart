import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/model/location_model.dart';
import 'package:xplore/model/mongoose_model.dart';
import 'package:xplore/model/move_plan_trip_model.dart';

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
  final List<List<MovePlanTrip>> _plan = [];

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
            child: const Text("done")),
        SizedBox(
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

    //widget.planQuery["trip"] = [planList.join(",")];
    widget.planTripBloc.add(SaveTrip(body: widget.planQuery));
  }
}
