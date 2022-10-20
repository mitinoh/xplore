import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:xplore/presentation/screen/planner/bloc_current_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/sc_trip_detail.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';
import 'package:xplore/utils/imager.dart';

import '../../../common_widgets/wg_circle_image.dart';

class CurrentPlannedTripList extends StatelessWidget {
  CurrentPlannedTripList({
    Key? key,
  }) : super(key: key);

  late ThemeData themex;

  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return BlocProvider(
      create: (_) =>
          BlocProvider.of<CurrentPlannerBloc>(context)..add(GetCurrentPlannedTrip()),
      child: BlocListener<CurrentPlannerBloc, CurrentPlannerState>(
        listener: (context, state) {
          if (state is CurrentPlannerError) {
            SbError().show(context);
          }
        },
        child: BlocBuilder<CurrentPlannerBloc, CurrentPlannerState>(
          builder: (context, state) {
            if (state is CurrentPlannerInitial || state is CurrentPlannerLoading) {
              return const LoadingIndicator();
            } else if (state is CurrentPlantripLoadedTrip) {
              return state.inProgressTrip.length > 0
                  ? _gridList(state.inProgressTrip)
                  : Text(". . .",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: themex.indicatorColor));
            } else {
              return ErrorScreen(state: state);
            }
          },
        ),
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
                return _currentTripCard(pTripList[index], context, themex);
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
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return TripDetailScreen(
                    planTrip: pTrip,
                  );
                });
          },
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [themex.primaryColor, COLOR_CONST.DEFAULT40]),
                  shape: BoxShape.circle),
              child: _tripImage(pTrip),
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
              "in progress...",
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w300, color: themex.disabledColor),
            ),
          ],
        )
      ],
    );
  }

  Widget _tripImage(PlannerModel pTrip) {
    return CircleImageWidget(
        radius: 35, imageUrl: Img.getLocationUrl(pTrip.plannedLocation?[0].location));
  }

  Future<String> _getUserLocation(PlannerModel pt) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.geometry?.coordinates?[0] ?? 0.0, pt.geometry?.coordinates?[1] ?? 0.0);
    Placemark place = placemarks[0];

    return '${place.locality}, ${place.country}, ${place.name}, ${place.street}';
  }
}
