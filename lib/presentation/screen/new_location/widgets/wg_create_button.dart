import 'package:flutter/material.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateButtonWidget extends StatelessWidget {
  CreateButtonWidget({Key? key}) : super(key: key);

  late BuildContext _buildContext;
  late ThemeData themex;
  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    themex = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        InkWell(
            onTap: () {
              _createNewLocation();
            },
            child: ConfirmButton(
                text: "Raccomanda destinazione",
                colors: themex.primaryColor,
                colorsText: themex.canvasColor)),
        const SizedBox(height: 30),
      ],
    );
  }

  void _createNewLocation() {
    LocationModel newLocation =
        BlocProvider.of<NewLocationBloc>(_buildContext).newLocation;

    bool allValueValid = true;
    newLocation.toJson().forEach((k, v) => {
          if (!validateField(v)) {allValueValid = false}
        });

    allValueValid = true;
    if (allValueValid) {
      BlocProvider.of<NewLocationBloc>(_buildContext)
          .add(CreateNewLocation(location: newLocation));
    } else {
      ScaffoldMessenger.of(_buildContext).showSnackBar(
        const SnackBar(
          content: Text("tutti i campi devono essere riempiti"),
        ),
      );
    }
  }

  bool validateField(field) {
    if (field != Null && field != null) {
      if (field is List) {
        return field.isNotEmpty;
      }
      return field?.trim()?.length > 6;
    }
    return false;
  }
}
