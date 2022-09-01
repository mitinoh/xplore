import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/presentation/screen/new_location/widgets/bs_category.dart';
import 'package:xplore/presentation/screen/new_location/widgets/image_imported.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_base_info.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_category.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_header.dart';
import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/home/bloc/home_bloc.dart';
import 'package:xplore/presentation/screen/home/bloc/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/presentation/screen/home/widget/wg_list_card.dart';
import 'package:xplore/presentation/screen/new_location/widgets/wg_image.dart';

class CreateButtonWidget extends StatelessWidget {
  CreateButtonWidget({Key? key}) : super(key: key);

  late BuildContext _buildContext;
  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Column(
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            _createNewLocation();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15.0, left: 15),
                  child: Icon(
                    Iconsax.tick_circle,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Raccomanda destinazione",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
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
