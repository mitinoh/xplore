import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/widget/lock_trip_bottom_sheet.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/plan_trip_model.dart';

class PlannedTripList extends StatelessWidget {
  const PlannedTripList({Key? key, required this.planTripBloc})
      : super(key: key);
  final PlantripBloc planTripBloc;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var lightDark = Theme.of(context);
    return BlocProvider(
      create: (_) => planTripBloc,
      child: BlocListener<PlantripBloc, PlantripState>(
        listener: (context, state) {
          if (state is PlanTripErrorState) {
            SnackBarMessage.show(context, state.message ?? '');
          }
        },
        child: BlocBuilder<PlantripBloc, PlantripState>(
          builder: (context, state) {
            if (state is PlantripInitial) {
              return const LoadingIndicator();
            } else if (state is PlantripLoadingPlannedTrip) {
              return const LoadingIndicator();
            } else if (state is PlantripLoadedPlannedTrip) {
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
            } else if (state is PlanTripErrorState) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Future<String> getUserLocation(PlanTripModel pt) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    /**List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.geometry?.coordinates?[0] ?? 0.0,
        pt.geometry?.coordinates?[1] ?? 0.0);*/
    //Placemark place = placemarks[0];
    return pt.tripName!.replaceFirst(pt.tripName![0], pt.tripName![0].toUpperCase()) +
        ', ' +
        formatter.format(pt.goneDate!.toUtc());
  }
}
