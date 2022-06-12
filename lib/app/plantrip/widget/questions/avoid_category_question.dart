import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/plantrip/bloc/plantrip_bloc.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/core/widgets/confirm_button.dart';
import 'package:xplore/core/widgets/header_name.dart';
import 'package:xplore/core/widgets/subtitle.dart';
import 'package:xplore/core/widgets/widget_core.dart';

class AvoidCategoryQuestion extends StatelessWidget {
  AvoidCategoryQuestion({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  @override
  Widget build(context) {
    return BlocProvider(
      create: (_) => LocationcategoryBloc()..add(GetLocationCategoryList()),
      child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is LocationcategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationcategoryBloc, LocationcategoryState>(
          builder: (context, state) {
            if (state is LocationcategoryInitial) {
              return const LoadingIndicator();
            } else if (state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationcategoryLoaded) {
              return categoryToAvoidWidget();
            } else if (state is LocationcategoryError) {
              return Container();
            } else {
              return Text("aa");
            }
          },
        ),
      ),
    );
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
              children: [
                HeaderName(
                    message: "Quali categorie non vuoi che ti suggeriamo ",
                    questionMark: true)
              ],
            ),
            const SizedBox(height: 20),
            const Subtitle(
                text: "Seleziona le categorie che vorresti evitare in vacanza"),
            const SizedBox(height: 20),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              children: const <Widget>[CategoryPreference()],
            ),
          ],
        ),
        InkWell(
            onTap: () {
              setCategoryToAvoid();
            },
            child: const ConfirmButton(
              text: "prossima domanda",
            )),
      ],
    );
  }

  void setCategoryToAvoid() {
    if (CategoryPreference.catSelected.isNotEmpty) {
      context.read<PlantripBloc>().planTripQuestionsMap["avoidCategory"] =
          CategoryPreference.catSelected.join(',').toString();
      // mng.filter?.putIfAbsent("locationcategory",  () => 'nin:' + CategoryPreference.catSelected.join(','));
    }

    context
        .read<PlantripBloc>()
        .add(PlanTripChangeQuestionEvent(increment: true));
    //planQuery["avoidCategory"] = CategoryPreference.catSelected;
    //incrementQuest();
  }
}
