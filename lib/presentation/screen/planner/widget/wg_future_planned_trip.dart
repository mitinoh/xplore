import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/presentation/common_widgets/wg_circle_text.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/planner/bloc_future_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/widget/sc_trip_detail.dart';

class FuturePlannedTripList extends StatelessWidget {
  FuturePlannedTripList({Key? key}) : super(key: key);

  late ThemeData _lightDark;
  late BuildContext _blocContext;
  @override
  Widget build(BuildContext context) {
    _lightDark = Theme.of(context);
    _blocContext = context;
    return BlocProvider(
        create: (_) =>
            BlocProvider.of<FuturePlannerBloc>(context)..add(GetFuturePlannedTrip()),
        child:
            BlocBuilder<FuturePlannerBloc, FuturePlannerState>(builder: (context, state) {
          if (state is FuturePlannerInitial || state is FuturePlannerLoading) {
            return const LoadingIndicator();
          } else if (state is FuturePlannerTripLoaded) {
            return _listView(state.props as List<PlannerModel>);
          } else {
            return Text("error");
          }
        }));
  }

  Widget _listView(List<PlannerModel> pTrip) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: pTrip.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<String>(
              future: _getUserLocation(pTrip[index]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () {
                      _tripDetailBottomSheet(pTrip[index]);
                    },
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _tripInfo(index, snapshot.data ?? '')),
                        Divider(
                          height: 30,
                          color: _lightDark.primaryColor.withOpacity(0.1),
                        ),
                      ],
                    ),
                  );
                }
                return const LoadingIndicator();
              });
        });
  }

  List<Widget> _tripInfo(int index, String text) {
    return [
      Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleTextWidget(text: index + 1)),
      Expanded(
        child: Text(text,
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _lightDark.primaryColor)),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Iconsax.arrow_right_1,
            color: _lightDark.primaryColor,
          ))
    ];
  }

  Future<String> _getUserLocation(PlannerModel pt) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return '${pt.tripName!.replaceFirst(pt.tripName![0], pt.tripName![0].toUpperCase())}, ${formatter.format(pt.goneDate!.toUtc())}';
  }

  void _tripDetailBottomSheet(PlannerModel pTrip) {
    showModalBottomSheet(
        context: _blocContext,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return TripDetailScreen(planTrip: pTrip);
        });
  }
}
