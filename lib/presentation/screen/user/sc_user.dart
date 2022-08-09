import 'package:flutter/material.dart';
import 'package:xplore/model/api/mongoose.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/repository/auth_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/bloc/bloc.dart';
import 'package:xplore/presentation/screen/user/widget/sliver_bar.dart';
import 'package:xplore/presentation/screen/user/widget/sliver_box_adapter.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key, this.user}) : super(key: key);
  UserModel? user;

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
    _blocContext = context;
    return BlocProvider(
      create: (context) => BlocProvider.of<UserBloc>(
          context), //UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
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
    return TabBarView(children: [Text("data 1 "), Text("data 2 ")]);
  }

  Widget _getSliverBar(UserModel user) {
    return SliverBarWidget(user: user);
  }

  Widget _sliverBoxAdapter(UserModel user) {
    return SliverBoxAdapterWidget(tabs: tabs, user: user);
  }

  Widget _defaultTabController(UserModel user) {
    return DefaultTabController(
        length: tabs.length, // This is the number of tabs.
        child: Scaffold(
          //backgroundColor: const Color(0xffF3F7FA),
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
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
    // Considerare la possibiilità di fare questa cosa in app.dart
    if (widget.user == null) {
      AuthRepository authRepository =
          RepositoryProvider.of<AuthRepository>(_blocContext);
      String fid = await authRepository.getUserFid();
      BlocProvider.of<UserBloc>(_blocContext)..add(GetUserData(fid: fid));
    }
  }
}
