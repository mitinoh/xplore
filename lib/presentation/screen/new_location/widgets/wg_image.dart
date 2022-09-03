import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/presentation/screen/new_location/widgets/image_imported.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/presentation/screen/search/bloc/bloc.dart';
import 'package:xplore/utils/class/debouncer.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  final ThemeData themex = App.themex;

  @override
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
                color: Colors.blue,
              ),
            ),
            Text(
              "Aggiungi foto",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14, color: themex.hoverColor),
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

    String base64Image = "";
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
    }
    BlocProvider.of<NewLocationBloc>(context).newLocation.base64 = base64Image;
  }
}