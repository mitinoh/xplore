import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/search/bloc/bloc.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_grid_location.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_grid_user.dart';

class GridWidget extends StatelessWidget {
  GridWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: true,
        child: BlocProvider(
          create: (_) =>
              context.read<SearchLocationBloc>()..add(GetSearchLocationList()),
           child: BlocListener<SearchLocationBloc, SearchLocationState>(
            listener: (context, state) {
              if (state is SearchLocationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: BlocBuilder<SearchLocationBloc, SearchLocationState>(
              builder: (context, state) {
                if (state is SearchLocationInitial ||
                    state is SearchUserLoading) {
                  return const LoadingIndicator();
                } else if (state is SearchLocationLoaded) {
                  return _locationGrid(state.props);
                } else if (state is SearchUserLoaded) {
                  return _userGrid(state.props);
                } else if (state is SearchLocationError) {
                  return const Text("error 1");
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          ),
        ));
  }

  _userGrid(List<UserModel> _userList) {
    return UserGridWidget(userList: _userList);
  }

  _locationGrid(List<LocationModel> _locationList) {
    return LocationGridWidget(locationsList: _locationList);
  }
}
