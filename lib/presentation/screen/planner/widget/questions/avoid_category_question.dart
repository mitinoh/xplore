import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/model/location_category_model.dart';
import 'package:xplore/model/repository/location_category_repository.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/gridView_category_preference.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/common_widgets/subtitle.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/home/bloc_location_category/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/utils/logger.dart';

import '../../bloc_question/question_bloc.dart';

class AvoidCategoryQuestion extends StatelessWidget {
  AvoidCategoryQuestion({
    Key? key,
  }) : super(key: key);

  late BuildContext _context;
  List<LocationCategoryModel> selectedCategories = [];
  @override
  Widget build(context) {
    var lightDark = Theme.of(context);
    _context = context;
    return BlocProvider(
      create: (_) => LocationCategoryBloc(
          locationCategroyRepository:
              RepositoryProvider.of<LocationCategoryRepository>(context))
        ..add(GetLocationCategoryList()),
      child: BlocListener<LocationCategoryBloc, LocationCategoryState>(
        listener: (context, state) {
          if (state is LocationCategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationCategoryBloc, LocationCategoryState>(
          builder: (context, state) {
            if (state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationCategoryLoaded) {
              return categoryToAvoidWidget(lightDark);
            } else if (state is LocationCategoryError) {
              return Container();
            } else {
              return Text("aa");
            }
          },
        ),
      ),
    );
  }

  Column categoryToAvoidWidget(lightDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeaderName(message: "Categorie da evitare ", questionMark: true)
              ],
            ),
            const SizedBox(height: 20),
            Subtitle(
              text:
                  "Seleziona le categorie che vorresti evitare in vacanza oppure prosegui.",
              colors: lightDark.primaryColor,
            ),
            const SizedBox(height: 20),
            /*ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              children: const <Widget>[CategoryPreference()],
            ),*/
            GridViewCategoryPreference(
              selectedCategories: selectedCategories,
              update: _incrementCounter,
            )
          ],
        ),
        InkWell(
            onTap: () {
              setCategoryToAvoid();
              print("1");
              print(selectedCategories);
            },
            child: ConfirmButton(
              text: "prossimaaaaa domanda",
              colors: Colors.blue,
              colorsText: Colors.black,
            )),
      ],
    );
  }

  void _incrementCounter(List<LocationCategoryModel> asd) {
    Logger.info(asd.join());
  }

  void setCategoryToAvoid() {
    BlocProvider.of<PlannerQuestionBloc>(_context)
        .planTripQuestionsMap["avoidCategory"] = [];
    // CategoryPreference.catSelected.join(',').toString();
    // mng.filter?.putIfAbsent("locationcategory",  () => 'nin:' + CategoryPreference.catSelected.join(','));

    BlocProvider.of<PlannerQuestionBloc>(_context).add(PlannerChangeQuestion());
    //planQuery["avoidCategory"] = CategoryPreference.catSelected;
    //incrementQuest();
  }
}
