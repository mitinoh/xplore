import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/image_tile.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_uploaded_location/bloc.dart';

class UploadedLocationTabBarWidget extends StatefulWidget {
  const UploadedLocationTabBarWidget({Key? key, required this.user})
      : super(key: key);
  final UserModel user;
  @override
  State<UploadedLocationTabBarWidget> createState() =>
      _UploadedLocationTabBarWidgetState();
}

class _UploadedLocationTabBarWidgetState extends State<UploadedLocationTabBarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UploadedLocationBloc>(context),
      child: BlocBuilder<UploadedLocationBloc, UploadedLocationState>(
        builder: (context, state) {
          if (state is UploadedLocationLoadedState) {
            return RefreshIndicator(
              color: widget.user == null ? Colors.white : Colors.transparent,
              backgroundColor:
                  widget.user == null ? Colors.blue : Colors.transparent,
              edgeOffset: 0,
              onRefresh: () async {
                /*
                  if (widget.user == null) {
                    context.read<SavedLocationBloc>().add(
                        SavedLocationGetUserListEvent(
                            savedLocationList: state.savedLocationList,
                            uid: widget.user?.sId));
                    return Future<void>.delayed(const Duration(seconds: 1));
                  } else
                    return;
                    */
              },
              child: (state.uploadedLocationList.isNotEmpty)
                  ? CustomScrollView(
                      // key: PageStorageKey<String>(obj["name"]),
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 1.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // commento
                              return state.uploadedLocationList[index].saved ==
                                      true
                                  ? InkWell(
                                      onTap: () {
                                        /*
                                              DetailLocationModal(
                                                loc: state.savedLocationList[index],
                                                fromLikedSection: true,
                                                callback: () {
                                                  setState(() {
                                                    state.savedLocationList[index]
                                                        .saved = state
                                                                .savedLocationList[
                                                                    index]
                                                                .saved !=
                                                            true
                                                        ? false
                                                        : true;
                                                  });
                                                },
                                              ).show(context);
                                   */
                                      },
                                      child: ImageTile(
                                          location:
                                              state.uploadedLocationList[index]),
                                    )
                                  : const SizedBox();
                            },
                            childCount: state.uploadedLocationList
                                .map((e) => e.saved)
                                .length,
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: ListView(
                        children: const [Text("EmptyData()")],
                      ),
                    ),
            );
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }
}
