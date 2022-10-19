import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/common_widgets/gridView_category_preference.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/common_widgets/subtitle.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';

class AvoidCategoryQuestion extends StatelessWidget {
  AvoidCategoryQuestion({
    Key? key,
  }) : super(key: key);

  late BuildContext _context;
  late ThemeData themex;
  List<LocationCategoryModel> selectedCategories = [];

  @override
  Widget build(context) {
    themex = Theme.of(context);
    _context = context;
    return categoryToAvoidWidget();
  }

  Column categoryToAvoidWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [HeaderName(message: "Categories to avoid", questionMark: true)],
            ),
            const SizedBox(height: 20),
            Subtitle(
              text:
                  "Tell us what you are not interested in and we will not propose places about it.",
              colors: themex.disabledColor,
            ),
            const SizedBox(height: 20),
            /*ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              children: const <Widget>[CategoryPreference()],
            ),*/
            GridViewCategoryPreference(
              selectedCategories: selectedCategories,
              updateSelectedCategories: _setSelectedCategories,
            )
          ],
        ),
        InkWell(
            onTap: () {
              setCategoryToAvoid();
            },
            child: ConfirmButton(
                text: "Next question",
                colors: themex.primaryColor,
                colorsText: themex.canvasColor)),
      ],
    );
  }

  void _setSelectedCategories(List<LocationCategoryModel> asd) {
    BlocProvider.of<PlannerQuestionBloc>(_context).planTripQuestions.avoidCategory = asd;
  }

  void setCategoryToAvoid() {
    BlocProvider.of<PlannerQuestionBloc>(_context).planTripQuestions.avoidCategory =
        selectedCategories;
    // CategoryPreference.catSelected.join(',').toString();
    // mng.filter?.putIfAbsent("locationcategory",  () => 'nin:' + CategoryPreference.catSelected.join(','));

    BlocProvider.of<PlannerQuestionBloc>(_context).add(PlannerChangeQuestion());
    //planQuery["avoidCategory"] = CategoryPreference.catSelected;
    //incrementQuest();
  }
}
