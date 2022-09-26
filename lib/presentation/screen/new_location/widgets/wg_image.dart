import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/presentation/screen/new_location/widgets/image_imported.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              "Aggiungi foto",
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

    String base64Image = "";
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      // base64Image = "data:image/png;base64," + base64Encode(bytes);
      base64Image =
          "data:image/jpeg;base64,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";
    }
    BlocProvider.of<NewLocationBloc>(context).newLocation.base64 = base64Image;
  }
}
