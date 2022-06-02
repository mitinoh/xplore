import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/snackbar_message.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'package:xplore/model/plan_trip_model.dart';

class CurrentPlannedTripList extends StatelessWidget {
  const CurrentPlannedTripList({Key? key, required this.planTripBloc})
      : super(key: key);
  final PlantripBloc planTripBloc;

  @override
  Widget build(BuildContext context) {
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
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: 175),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.currentPlanTripModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder<String>(
                      future:
                          getUserLocation(state.currentPlanTripModel[index]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return currentTripCard(
                              state.currentPlanTripModel[index]);
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
        ',' +
        place.country! +
        ',' +
        place.name! +
        ',' +
        place.street!;
  }

  Column currentTripCard(PlanTripModel pTrip) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 50,
            backgroundColor: UIColors.bluelight,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1528744598421-b7b93e12df15?ixlib=rb-1.2.1&ixid=&auto=format&fit=crop&w=928&q=80',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => const LoadingIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Iconsax.gallery_slash,
                          size: 30, color: UIColors.lightRed),
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 8, right: 8),
                          decoration: BoxDecoration(
                              color: UIColors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(
                            Iconsax.play,
                            size: 25,
                            color: Colors.black,
                          ),
                        )))
              ],
            )),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pTrip.tripName ?? '',
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "in corso...",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
