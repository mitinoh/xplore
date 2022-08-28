import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:xplore/presentation/screen/home/widget/wg_home_card.dart';

class BuildListCardHome extends StatefulWidget {
  const BuildListCardHome({Key? key}) : super(key: key);

  @override
  State<BuildListCardHome> createState() => _BuildListCardHomeState();
}

class _BuildListCardHomeState extends State<BuildListCardHome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: context.read<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return const LoadingIndicator();
            } else if (state is HomeLoaded) {
              return getCards(state.homeList);
            } else {
              return Expanded(child: Center(child: Text('Error')));
            }
          },
        ));
  }

  HomeMainCard getCards(List<LocationModel> homeModel) {
    // TODO: controllare che modelLoc.length > 0
    return HomeMainCard(locationsList: homeModel);
  }
}
