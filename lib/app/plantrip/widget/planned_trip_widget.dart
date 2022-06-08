import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
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
    return BlocProvider(
      create: (_) => planTripBloc,
      child: BlocListener<PlantripBloc, PlantripState>(
        listener: (context, state) {
          if (state is PlanTripError) {
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
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: UIColors.platinium,
                                      child: Icon(
                                        Iconsax.hashtag,
                                        color: UIColors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(snapshot.data ?? '',
                                        overflow: TextOverflow.visible,
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              const Divider(height: 30),
                            ],
                          );
                        }
                        return const LoadingIndicator();
                      });
                },
              );
            } else if (state is PlanTripError) {
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.coordinate?.lat ?? 0.0, pt.coordinate?.lng ?? 0.0);
    Placemark place = placemarks[0];
    return place.locality! +
        ', ' +
        place.country! +
        ', ' +
        pt.goneDate.toString();
  }
}
