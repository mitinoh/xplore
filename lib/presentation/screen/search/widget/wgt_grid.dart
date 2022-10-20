import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/search/bloc/bloc.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_grid_location.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_grid_user.dart';
import 'package:xplore/presentation/screen/search/widget/wgt_search_bar.dart';

class GridWidget extends StatelessWidget {
  GridWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: true,
        child: BlocProvider(
          create: (_) => SearchLocationBloc(
              homeRepository: RepositoryProvider.of<HomeRepository>(context),
              userRepository: RepositoryProvider.of<UserRepository>(context))
            ..add(GetSearchLocationList()),
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
            child: Column(
              children: [
                _searchBar(),
                SizedBox(
                  height: 15,
                ),
                _searchListener(),
              ],
            ),
          ),
        ));
  }

  BlocListener<SearchLocationBloc, SearchLocationState> _searchListener() {
    return BlocListener<SearchLocationBloc, SearchLocationState>(
        listener: (context, state) {
          if (state is SearchLocationError) {
            SbError().show(context);
          }
        },
        child: _searchBuilder());
  }

  BlocBuilder<SearchLocationBloc, SearchLocationState> _searchBuilder() {
    return BlocBuilder<SearchLocationBloc, SearchLocationState>(
      builder: (context, state) {
        if (state is SearchLocationInitial || state is SearchUserLoading) {
          return const LoadingIndicator();
        } else if (state is SearchLocationLoaded) {
          return _locationGrid(state.searchLocation);
        } else if (state is SearchUserLoaded) {
          return _userGrid(state.searchUser);
        } else {
          return ErrorScreen(state: state);
        }
      },
    );
  }

  _userGrid(List<UserModel> _userList) {
    return UserGridWidget(userList: _userList);
  }

  _locationGrid(List<LocationModel> _locationList) {
    return LocationGridWidget(locationsList: _locationList);
  }

  Widget _searchBar() {
    return SearchBarWidget();
  }
}
