import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:xplore/presentation/screen/home/widget/home_card_widget.dart';

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
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            //SnackBarMessage.show(context, state.message );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
              return const LoadingIndicator();
            } else if (state is HomeLoaded) {
              return getCards(state.homeList);
            } else if (state is HomeError) {
              return Expanded(
                child: Center(
                  child: Text('Error while loading data'),
                ),
              );
            } else {
              return Expanded(
                child: Center(
                  child: Text('Unknown state'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  HomeMainCard getCards(List<LocationModel> homeModel) {
    // TODO: controllare che modelLoc.length > 0
    return HomeMainCard(locationsList: homeModel);
  }
}
