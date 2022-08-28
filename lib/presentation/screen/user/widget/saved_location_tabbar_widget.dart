import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/empty_data.dart';
import 'package:xplore/presentation/common_widgets/image_tile.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedLocationTabBarWidget extends StatefulWidget {
  const SavedLocationTabBarWidget({Key? key, required this.user})
      : super(key: key);
  final UserModel user;
  @override
  State<SavedLocationTabBarWidget> createState() =>
      _SavedLocationTabBarWidgetState();
}

class _SavedLocationTabBarWidgetState extends State<SavedLocationTabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SavedLocationBloc>(context),
      child: BlocBuilder<SavedLocationBloc, SavedLocationState>(
        builder: (context, state) {
          if (state is SavedLocationLoadedState) {
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
              child: (state.savedLocationList.isNotEmpty)
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
                              return state.savedLocationList[index].saved ==
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
                                              state.savedLocationList[index]),
                                    )
                                  : const SizedBox();
                            },
                            childCount: state.savedLocationList
                                .map((e) => e.saved)
                                .length,
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: ListView(
                        children: const [EmptyData()],
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
