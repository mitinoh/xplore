import 'package:flutter/material.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/screen/user/bloc/bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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
  Widget build(BuildContext context) {
    _lightDark = Theme.of(context);
    _blocContext = context;
    return BlocProvider(
      create: (context) => UserBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return DefaultTabController(
              length: tabs.length, // This is the number of tabs.
              child: Scaffold(
                //backgroundColor: const Color(0xffF3F7FA),
                body: SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext ctx, bool innerBoxIsScrolled) {
                      // These are the slivers that show up in the "outer" scroll view.
                      return <Widget>[
                        _getSliverBar(),
                        _sliverBoxAdapter()
                      ];
                    },
                    body: Padding(
                        padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                        child: SafeArea(
                          top: false,
                          bottom: false,
                          child: getTabBarView(),
                        )),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget getTabBarView() {
    return TabBarView(children: [Text("data 1 "), Text("data 2 ")]);
  }

  Widget _getSliverBar() {
    return SliverBarWidget(user: widget.user);
  }

  _sliverBoxAdapter() {
    return SliverBoxAdapterWidget(tabs: tabs);
  }
}
