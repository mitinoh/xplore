import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final List<LocationCategoryModel> model;
  final SearchHomeBloc homeBloc;

  @override
  State<BuildListCardCategory> createState() => _BuildListCardCategoryState();
}

class _BuildListCardCategoryState extends State<BuildListCardCategory> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    return SafeArea(
      child: SizedBox(
        height: mediaQuery.size.height * 0.55,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Filtra per categorie",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: lightDark.primaryColor),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey)),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.model.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      toggleCategoryFilter(index);
                      widget.homeBloc
                          .add(const GetSearchLocationList(add: false));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: lightDark.splashColor,
                      ),
                      child: Text(
                        widget.model[index].name ?? '',
                        textAlign: TextAlign.center,
                        style: isCategoryFilterActive(index)
                            ? GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.green)
                            : GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
