import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/presentation/common_widgets/wg_circle_image.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:xplore/presentation/screen/planner/bloc_current_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/sc_trip_detail.dart';

class CurrentPlannedTripList extends StatelessWidget {
  CurrentPlannedTripList({
    Key? key,
  }) : super(key: key);

  late ThemeData lightDark;

  @override
  Widget build(BuildContext context) {
    lightDark = Theme.of(context);
    return BlocProvider(
      create: (_) =>
          BlocProvider.of<CurrentPlannerBloc>(context)..add(GetCurrentPlannedTrip()),
      child: BlocBuilder<CurrentPlannerBloc, CurrentPlannerState>(
        builder: (context, state) {
          if (state is PlannerInitial || state is CurrentPlannerLoading) {
            return const LoadingIndicator();
          } else if (state is CurrentPlantripLoadedTrip) {
            return _gridList(state.props as List<PlannerModel>);
          } else {
            return Text("not handled");
          }
        },
      ),
    );
  }

  Widget _gridList(List<PlannerModel> pTripList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisExtent: 175),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: pTripList.length,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder<String>(
            future: _getUserLocation(pTripList[index]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _currentTripCard(pTripList[index], context, lightDark);
              }
              return const LoadingIndicator();
            });
      },
    );
  }

  Widget _currentTripCard(PlannerModel pTrip, context, lightDarkt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripDetailScreen(
                        planTrip: pTrip,
                      )),
            );
          },
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff9fccfa), //f0ebc0
                    Color(0xff0974f1), //9dddf4
                    //e93a28
                  ]),
                  shape: BoxShape.circle),
              child: Padding(padding: const EdgeInsets.all(2), child: _tripImage(pTrip)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                pTrip.tripName!
                    .replaceFirst(pTrip.tripName![0], pTrip.tripName![0].toUpperCase()),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: lightDarkt.primaryColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "in corso...",
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget _tripImage(PlannerModel pTrip) {
    return CircleImageWidget(
        imageUrl: "https://107.174.186.223.nip.io/img/location/${pTrip.id}.jpg");
  }

  Future<String> _getUserLocation(PlannerModel pt) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.geometry?.coordinates?[0] ?? 0.0, pt.geometry?.coordinates?[1] ?? 0.0);
    Placemark place = placemarks[0];

    return '${place.locality}, ${place.country}, ${place.name}, ${place.street}';
  }
}
