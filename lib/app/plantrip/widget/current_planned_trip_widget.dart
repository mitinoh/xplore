import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/plantrip/screen/trip_detail_screen.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/plan_trip_model.dart';

class CurrentPlannedTripList extends StatelessWidget {
  const CurrentPlannedTripList({Key? key, required this.planTripBloc})
      : super(key: key);
  final PlantripBloc planTripBloc;

  @override
  Widget build(BuildContext context) {
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
                              state.currentPlanTripModel[index],
                              context,
                              lightDark);
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
        pt.geometry?.coordinates?[0] ?? 0.0,
        pt.geometry?.coordinates?[1] ?? 0.0);
    Placemark place = placemarks[0];

    return place.locality! +
        ',' +
        place.country! +
        ',' +
        place.name! +
        ',' +
        place.street!;
  }

  Column currentTripCard(PlanTripModel pTrip, context, lightDarkt) {
    Config conf = Config();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            pTrip;
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
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: lightDarkt.scaffoldBackgroundColor,
                  child: CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl:
                              conf.getLocationImageUrl(pTrip.uid!.sId ?? ''),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const LoadingIndicator(),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(Iconsax.gallery_slash,
                                size: 30, color: UIColors.bluelight),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                pTrip.tripName!.replaceFirst(
                    pTrip.tripName![0], pTrip.tripName![0].toUpperCase()),
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
