import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:xplore/data/api/mongoose.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_uploaded_location/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';
import 'package:xplore/presentation/screen/user/widget/saved_location_tabbar_widget.dart';
import 'package:xplore/presentation/screen/user/widget/sliver_bar.dart';
import 'package:xplore/presentation/screen/user/widget/sliver_box_adapter.dart';
import 'package:xplore/presentation/screen/user/widget/uploaded_location_tabbar_widget.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key, this.userRef, this.visualOnly = false})
      : super(key: key);
  final UserModel? userRef;
  final bool visualOnly;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ThemeData _lightDark;
  late BuildContext _blocContext;

  final List<dynamic> tabs = <dynamic>[
    {"name": '❤️ Posti piaciuti', "event": () => {}},
    {"name": '📤 Caricati', "event": () => {}}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _lightDark = Theme.of(context);
    return BlocProvider(
      create: (context) => UserBloc(
          userRepository: RepositoryProvider.of<UserRepository>(
              context)), //UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          _blocContext = context;
          if (state is UserInitial) {
            setUserData();
            return LoadingIndicator();
          } else if (state is UserDataLoaded) {
            return _defaultTabController(state.userData);
          } else if (state is UserError) {
            return const Text("error 1");
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }

  Widget getTabBarView(UserModel user) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SavedLocationBloc()
              ..add(GetUserSavedLocationList(
                  savedLocationList: [], uid: user.id ?? '')),
          ),
          BlocProvider(
            create: (context) => UploadedLocationBloc()
              ..add(GetUserUploadedLocationList(uploadedLocationList: [])),
          )
        ],
        child: TabBarView(children: [
          SavedLocationTabBarWidget(user: user),
          UploadedLocationTabBarWidget(user: user)
        ]));
  }

  Widget _getSliverBar(UserModel user) {
    return SliverBarWidget(user: user, visualOnly: widget.visualOnly);
  }

  Widget _sliverBoxAdapter(UserModel user) {
    return SliverBoxAdapterWidget(
      tabs: tabs,
      user: user,
      visualOnly: widget.visualOnly,
    );
  }

  Widget _defaultTabController(UserModel user) {
    return DefaultTabController(
        length: tabs.length, // This is the number of tabs.
        child: Scaffold(
          //backgroundColor: const Color(0xffF3F7FA),
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[_getSliverBar(user), _sliverBoxAdapter(user)];
              },
              body: Padding(
                  padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: getTabBarView(user),
                  )),
            ),
          ),
        ));
  }

  void setUserData() async {
    String? fid;
    if (widget.userRef == null) {
      AuthRepository authRepository =
          RepositoryProvider.of<AuthRepository>(_blocContext);
      fid = await authRepository.getUserFid();
    }
    BlocProvider.of<UserBloc>(_blocContext)
      ..add(GetUserData(fid: fid, user: widget.userRef));
  }
}
