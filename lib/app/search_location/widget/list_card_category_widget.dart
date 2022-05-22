import 'package:flutter/material.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/app/search_location/bloc/search_location_bloc.dart';
import 'package:xplore/model/location_category_model.dart';

class BuildListCardCategory extends StatefulWidget {
  const BuildListCardCategory(
      {Key? key,
      required this.context,
      required this.model,
      required this.homeBloc})
      : super(key: key);

  final BuildContext context;
  final List<LocationCategory> model;
  final SearchHomeBloc homeBloc;

  @override
  State<BuildListCardCategory> createState() => _BuildListCardCategoryState();
}

class _BuildListCardCategoryState extends State<BuildListCardCategory> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.5,
      child: ListView.builder(
        itemCount: widget.model.length,
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            onPressed: () {
              toggleCategoryFilter(index);
              widget.homeBloc.add(const GetSearchLocationList(add: false));
            },
            child: Text(
              widget.model[index].name ?? '',
              style: isCategoryFilterActive(index)
                  ? const TextStyle(
                      color: Colors.green,
                    )
                  : const TextStyle(
                      color: Colors.black,
                    ),
            ),
          );
        },
      ),
    );
  }

  toggleCategoryFilter(int index) {
    if (HomeRepository.categoryFilter.contains(widget.model[index].iId)) {
      setState(() {
        HomeRepository.categoryFilter.remove(widget.model[index].iId);
      });
    } else {
      setState(() {
        HomeRepository.categoryFilter.add(widget.model[index].iId ?? '');
      });
    }
  }

  bool isCategoryFilterActive(int index) {
    return HomeRepository.categoryFilter.contains(widget.model[index].iId);
  }
}
