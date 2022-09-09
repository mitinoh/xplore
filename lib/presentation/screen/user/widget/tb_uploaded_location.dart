import 'package:flutter/material.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/common_widgets/empty_data.dart';
import 'package:xplore/presentation/common_widgets/image_tile.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_uploaded_location/bloc.dart';

class UploadedLocationTabBarWidget extends StatefulWidget {
  const UploadedLocationTabBarWidget({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  State<UploadedLocationTabBarWidget> createState() =>
      _UploadedLocationTabBarWidgetState();
}

class _UploadedLocationTabBarWidgetState extends State<UploadedLocationTabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UploadedLocationBloc>(context),
      child: BlocBuilder<UploadedLocationBloc, UploadedLocationState>(
        builder: (context, state) {
          if (state is UploadedLocationLoadedState) {
            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: Colors.blue,
              edgeOffset: 0,
              onRefresh: () {
                _onRefresh(state);
                return Future<void>.delayed(const Duration(seconds: 1));
              },
              child: (state.uploadedLocationList.isNotEmpty)
                  ? _locationListView(state)
                  : _emptyList(),
            );
          } else if (state is UploadedLocationLoadingState) {
            return const LoadingIndicator();
          } else if (state is UploadedLocationError) {
            return ErrorScreen(state: state, message: state.message);
          } else {
            return ErrorScreen(state: state);
          }
        },
      ),
    );
  }

  CustomScrollView _locationListView(UploadedLocationLoadedState state) {
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
              return state.uploadedLocationList[index].saved == true
                  ? InkWell(
                      onTap: () {
                        _showDetailLocationModal(state, index).show(context);
                      },
                      child: ImageTile(location: state.uploadedLocationList[index]),
                    )
                  : const SizedBox();
            },
            childCount: state.uploadedLocationList.length,
          ),
        )
      ],
    );
  }

  DetailLocationModal _showDetailLocationModal(
      UploadedLocationLoadedState state, int index) {
    return DetailLocationModal(
      loc: state.uploadedLocationList[index],
      fromLikedSection: true,
      callback: () {
        setState(() {
          state.uploadedLocationList[index].saved =
              state.uploadedLocationList[index].saved != true ? false : true;
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

  void _onRefresh(UploadedLocationLoadedState state) async {
    context.read<UploadedLocationBloc>().add(GetUserUploadedLocationList(
        uploadedLocationList: state.uploadedLocationList, uid: widget.user.id));
  }

  UserModel get user {
    return widget.user;
  }
}
