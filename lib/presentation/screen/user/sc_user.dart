import 'package:flutter/material.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc_saved_location/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_uploaded_location/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/bloc.dart';
import 'package:xplore/presentation/screen/user/widget/tb_saved_location.dart';
import 'package:xplore/presentation/screen/user/widget/wg_sliver_bar.dart';
import 'package:xplore/presentation/screen/user/widget/wg_sliver_box_adapter.dart';
import 'package:xplore/presentation/screen/user/widget/tb_uploaded_location.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key, this.userRef, this.visualOnly = false}) : super(key: key);
  final UserModel? userRef;
  final bool visualOnly;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late BuildContext _blocContext;

  final List<dynamic> tabs = <dynamic>[
    {"name": '❤️ Posti piaciuti', "event": () => {}},
    {"name": '📤 Caricati', "event": () => {}}
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          _blocContext = context;
          if (state is UserInitial) {
            _setUserData();
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
            create: (context) =>
                SavedLocationBloc()..add(GetUserSavedLocationList(uid: user.id)),
          ),
          BlocProvider(
            create: (context) =>
                UploadedLocationBloc()..add(GetUserUploadedLocationList()),
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
        length: tabs.length,
        child: Scaffold(
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                return <Widget>[_getSliverBar(user), _sliverBoxAdapter(user)];
              },
              body: Padding(
                padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: getTabBarView(user),
                ),
              ),
            ),
          ),
        ));
  }

  void _setUserData() async {
    String? fid;
    if (widget.userRef == null) {
      AuthRepository authRepository = RepositoryProvider.of<AuthRepository>(_blocContext);
      fid = await authRepository.getUserFid();
    }
    BlocProvider.of<UserBloc>(_blocContext)
      ..add(GetUserData(fid: fid, user: widget.userRef));
  }
}
