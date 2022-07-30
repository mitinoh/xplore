import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/widget/home_card_widget.dart';
import 'package:xplore/core/widgets/snackbar_message.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/location_model.dart';

class BuildListCardHome extends StatefulWidget {
  const BuildListCardHome(
      {Key? key, required this.homeBloc, required this.pageController})
      : super(key: key);

  final HomeBloc homeBloc;
  final PageController pageController;

  @override
  State<BuildListCardHome> createState() => _BuildListCardHomeState();
}

class _BuildListCardHomeState extends State<BuildListCardHome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.homeBloc,
      child: BlocListener<HomeBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            SnackBarMessage.show(context, state.message ?? '');
          }
          if (state is NearbyLocationFound) {
          }
        },
        child: BlocBuilder<HomeBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationHomeInitial || state is LocationHomeLoading) {
              return const LoadingIndicator();
            } else if (state is LocationHomeLoaded) {
              return getCards(state.homeModel);
            } else if (state is LocationError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  BuildMainCard getCards(List<LocationModel> homeModel) {
    // TODO: controllare che modelLoc.length > 0

    return BuildMainCard(
        model: homeModel,
        pageController: widget.pageController,
        locationBloc: widget.homeBloc);
  }
}
