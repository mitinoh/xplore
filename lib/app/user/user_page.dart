import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/user/bloc/user_bloc.dart';
import 'package:xplore/app/user/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserBloc _newsBloc = UserBloc();

  @override
  void initState() {
    _newsBloc.add(GetUserList());

     _newsBloc.add(Test(amount: 5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User-19 List')),
      body: _buildListUser(),
    );
  }

  Widget _buildListUser() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserInitial) {
                return _buildLoading();
              } else if (state is UserLoading) {
                return _buildLoading();
              } else if (state is UserLoaded) {
                return _buildCard(context, state.userModel);
              } else if (state is UserError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<UserModel> model) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model[index].a ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model[index].a ?? ""),
            )
          ],
        ) ;
      },
    );
    
    
     /*ListView.builder(
      itemCount: model.,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Country: ${model.countries![index].country}"),
                  Text(
                      "Total Confirmed: ${model.countries![index].totalConfirmed}"),
                  Text("Total Deaths: ${model.countries![index].totalDeaths}"),
                  Text(
                      "Total Recovered: ${model.countries![index].totalRecovered}"),
                  TextButton(
                      onPressed: () => {
                            debugPrint(model.countries![index].country),
                            _newsBloc.add(AddedUserElement())
                          },
                      child: const Text("Button"))
                ],
              ),
            ),
          ),
        );
      },
    );*/
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
