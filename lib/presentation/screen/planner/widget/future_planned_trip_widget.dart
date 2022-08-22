import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xplore/model/model/planner_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/planner/bloc_future_trip/bloc.dart';

class FuturePlannedTripList extends StatelessWidget {
  const FuturePlannedTripList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    var lightDark = Theme.of(context);
    return BlocProvider(
      create: (_) => BlocProvider.of<FuturePlannerBloc>(context)
        ..add(GetFuturePlannedTrip()),
      child: BlocListener<FuturePlannerBloc, FuturePlannerState>(
        listener: (context, state) {
          if (state is FuturePlannerError) {}
        },
        child: BlocBuilder<FuturePlannerBloc, FuturePlannerState>(
          builder: (context, state) {
            if (state is FuturePlannerInitial || state is FuturePlannerLoading) {
              return const LoadingIndicator();
            } else if (state is FuturePlannerTripLoaded) {
              return Text("loaded");
              /*
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.planTripModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder<String>(
                      future: getUserLocation(state.planTripModel[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return InkWell(
                            onTap: () {
                              
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useRootNavigator: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return const LockTripBottomSheet();
                                  });
                                  
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar(
                                        backgroundColor: UIColors.mainColor,
                                        child: Text((index + 1).toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(snapshot.data ?? '',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: lightDark.primaryColor)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Iconsax.arrow_right_1,
                                        color: lightDark.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 30,
                                  color:
                                      lightDark.primaryColor.withOpacity(0.1),
                                ),
                              ],
                            ),
                          );
                        }
                        return const LoadingIndicator();
                      });
                },
              );
       */
            } else if (state is FuturePlannerError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Future<String> getUserLocation(PlannerModel pt) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    /**List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.geometry?.coordinates?[0] ?? 0.0,
        pt.geometry?.coordinates?[1] ?? 0.0);*/
    //Placemark place = placemarks[0];
    return pt.tripName!
            .replaceFirst(pt.tripName![0], pt.tripName![0].toUpperCase()) +
        ', ' +
        formatter.format(pt.goneDate!.toUtc());
  }
}
