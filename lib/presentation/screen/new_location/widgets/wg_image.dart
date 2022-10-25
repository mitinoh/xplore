import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/presentation/screen/new_location/widgets/image_imported.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  XFile? image;
  final ImagePicker _picker = ImagePicker();

  late MediaQueryData mediaQueryX = MediaQuery.of(context);
  late ThemeData themex = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        locationImage(),
        image != null
            ? ImageImported(
                path: image != null ? image!.path : '',
              )
            : const SizedBox(),
        const SizedBox(height: 5),
      ],
    );
  }

  InkWell locationImage() {
    return InkWell(
      onTap: () {
        _getFromGallery();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: themex.cardColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Icon(
                Iconsax.gallery_add,
                color: themex.indicatorColor,
              ),
            ),
            Text(
              "Add photo",
              style: GoogleFonts.poppins(fontSize: 14, color: themex.disabledColor),
            ),
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null)
      setState(() {
        image = img;
      });

    if(img?.path != null) {
        BlocProvider.of<NewLocationBloc>(context).formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(
            img!.path,
            filename: img.name,
          ),
        });
    }
  }



}
