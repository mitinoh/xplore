import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/home/bloc/home_bloc.dart';
import 'package:xplore/presentation/screen/home/bloc/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/screen/home/widget/wg_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetLocationList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [BuildListCardHome()]));
    /*return MultiBlocProvider(providers: [],child: BuildListCardHome());*/
  }
}
