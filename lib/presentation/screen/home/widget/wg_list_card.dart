import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
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
              return _buildCards(state.props as List<LocationModel>);
            } else if (state is HomeError) {
              return ErrorScreen(state: state, message: state.message);
            } else {
              return ErrorScreen(state: state);
            }
          },
        ));
  }

  HomeMainCard _buildCards(List<LocationModel> homeModel) =>
      HomeMainCard(locationList: homeModel);
}
