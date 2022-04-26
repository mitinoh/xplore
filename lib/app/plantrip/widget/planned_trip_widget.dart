import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/plan_trip_model.dart';

class PlannedTripList extends StatelessWidget {
  const PlannedTripList({Key? key, required this.planTripBloc})
      : super(key: key);
  final PlantripBloc planTripBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => planTripBloc,
      child: BlocListener<PlantripBloc, PlantripState>(
        listener: (context, state) {
          if (state is PlanTripError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<PlantripBloc, PlantripState>(
          builder: (context, state) {
            if (state is PlantripInitial) {
              return LoadingIndicator();
            } else if (state is PlantripLoadingPlannedTrip) {
              return LoadingIndicator();
            } else if (state is PlantripLoadedPlannedTrip) {
              state.planTripModel;
              return BlocProvider(
                create: (_) => planTripBloc,
                child: BlocListener<PlantripBloc, PlantripState>(
                  listener: (context, state) {
                    if (state is PlanTripError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("error"),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<PlantripBloc, PlantripState>(
                    builder: (context, state) {
                      if (state is PlantripInitial) {
                        return LoadingIndicator();
                      } else if (state is PlantripLoadingPlannedTrip) {
                        return LoadingIndicator();
                      } else if (state is PlantripLoadedPlannedTrip) {
                        state.planTripModel;

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.planTripModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FutureBuilder<String>(
                                future:
                                    getUserLocation(state.planTripModel[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(snapshot.data ?? '');
                                  }
                                  return CircularProgressIndicator();
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

  Future<String> getUserLocation(PlanTrip pt) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.coordinate?.lat ?? 0.0, pt.coordinate?.lng ?? 0.0);
    Placemark place = placemarks[0];
    return place.locality! +
        ',' +
        place.country! +
        ',' +
        pt.goneDate.toString();
  }
}