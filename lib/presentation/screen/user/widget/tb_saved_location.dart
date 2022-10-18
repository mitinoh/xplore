import 'package:flutter/material.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/common_widgets/empty_data.dart';
import 'package:xplore/presentation/common_widgets/image_tile.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedLocationTabBarWidget extends StatefulWidget {
  const SavedLocationTabBarWidget({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<SavedLocationTabBarWidget> createState() => _SavedLocationTabBarWidgetState();
}

class _SavedLocationTabBarWidgetState extends State<SavedLocationTabBarWidget> {
  late ThemeData themex = Theme.of(context);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SavedLocationBloc>(context),
      child: BlocBuilder<SavedLocationBloc, SavedLocationState>(
        builder: (context, state) {
          if (state is SavedLocationLoadedState) {
            return RefreshIndicator(
              color: themex.indicatorColor,
              backgroundColor: themex.primaryColor,
              edgeOffset: 0,
              onRefresh: () {
                _onRefresh(state);
                return Future<void>.delayed(const Duration(seconds: 1));
              },
              child: (state.savedLocationList.isNotEmpty)
                  ? _locationListView(state)
                  : _emptyList(),
            );
          } else if (state is SavedLocationLoadingState) {
            return LoadingIndicator();
          } else {
            return ErrorScreen(state: state);
          }
        },
      ),
    );
  }

  CustomScrollView _locationListView(SavedLocationLoadedState state) {
    return CustomScrollView(
      // key: PageStorageKey<String>(obj["name"]),
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return state.savedLocationList[index].saved == true
                  ? InkWell(
                      onTap: () {
                        _showDetailLocationModal(state, index).show(context);
                      },
                      child: ImageTile(location: state.savedLocationList[index]),
                    )
                  : const SizedBox();
            },
            childCount: state.savedLocationList.length,
          ),
        )
      ],
    );
  }

  DetailLocationModal _showDetailLocationModal(
      SavedLocationLoadedState state, int index) {
    return DetailLocationModal(
      location: state.savedLocationList[index],
      // fromLikedSection: true,
      callback: () {
        setState(() {
          state.savedLocationList[index].saved =
              state.savedLocationList[index].saved != true ? false : true;
        });
      },
    );
  }

  Center _emptyList() {
    return Center(
      child: ListView(
        children: const [EmptyData()],
      ),
    );
  }

  void _onRefresh(SavedLocationLoadedState state) async {
    context.read<SavedLocationBloc>().add(GetUserSavedLocationList(
        savedLocationList: state.savedLocationList, uid: widget.user.id));
  }

  UserModel get user {
    return widget.user;
  }
}
