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
              return ListView.builder(
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

  Future<String> getUserLocation(PlanTrip pt) async {
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

  Container currentTripCard(PlanTrip pTrip) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xffcaefd7), //f0ebc0
              Color(0xfff5bfd7), //9dddf4
              Color(0xffabc9e9), //e93a28
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
          )),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xffcaefd7),
            foregroundColor: UIColors.violet,
            child: const Icon(
              Iconsax.play_circle,
              size: 60,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          currentTripInfo(pTrip),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Container currentTripInfo(PlanTrip pTrip) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("la tua vacanza in corso...",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
          continueTrip(pTrip),
          const SizedBox(height: 20),
          progressIndicator()
        ],
      ),
    );
  }

  Row continueTrip(PlanTrip pTrip) {
    return Row(
      children: [
        Expanded(
          child: Text(pTrip.tripName ?? '',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: UIColors.black)),
        ),
      ],
    );
  }

  Row progressIndicator() {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: 0.6,
            valueColor: AlwaysStoppedAnimation<Color>(UIColors.violet),
            backgroundColor: UIColors.violet.withOpacity(0.2),
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
      ],
    );
  }
}
