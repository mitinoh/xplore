import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/app/post/widgets/filters_bottom_sheet.dart';
import 'package:xplore/core/UIColors.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({Key? key}) : super(key: key);
  @override
  State<NewLocation> createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _indicationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();

  final HomeBloc _locationBloc = HomeBloc();

  late File imageFile;

  final ImagePicker _picker = ImagePicker();
  late CategoriesBottomSheet categoriesBottomSheet;
  @override
  void initState() {
    categoriesBottomSheet = CategoriesBottomSheet(locCatBloc: _locCatBloc);
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                headerTitle(),
                const SizedBox(
                  height: 20,
                ),
                headerDesc(),
                const SizedBox(height: 20),
                locationName(),
                const SizedBox(
                  height: 5,
                ),
                adressName(),
                const SizedBox(
                  height: 5,
                ),
                locationImage(),
                const SizedBox(
                  height: 5,
                ),
                locationDesc(),
                const SizedBox(
                  height: 5,
                ),
                locationCategories(),
                //locationCategories(),
                const SizedBox(
                  height: 20,
                ),
                footer(),
                const SizedBox(
                  height: 20,
                ),
                locationTips(),
                const SizedBox(
                  height: 20,
                ),
                addLocationBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell locationCategories() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return categoriesBottomSheet;
            });
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: UIColors.grey.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Icon(
                Iconsax.hashtag,
                color: UIColors.blue,
              ),
            ),
            Text(
              "Aggiungi categoria",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  InkWell addLocationBtn() {
    return InkWell(
      onTap: () {
        _createNewLocation();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: UIColors.lightGreen,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aggiungi luogo".toUpperCase(),
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Row footer() {
    return Row(
      children: [
        Expanded(
          child: Text(
              "Ci siamo quasi. Ora facoltivamente lascia qualche consiglio per i nuovi xplorer.",
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey)),
        )
      ],
    );
  }

  Row locationDesc() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: UIColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _descController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 144,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Breve descrizione del luogo che vuoi raccomandare...",
              hintStyle:
                  GoogleFonts.poppins(color: UIColors.grey, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.note,
                color: UIColors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row locationTips() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: UIColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _indicationController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 144,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText:
                  "Breve tips su come raggiungiere il luogo o in quale stagione lo consogli...",
              hintStyle:
                  GoogleFonts.poppins(color: UIColors.grey, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.lamp_on,
                color: UIColors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  InkWell locationImage() {
    return InkWell(
      onTap: () {
        _getFromGallery();
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: UIColors.grey.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Icon(
                Iconsax.gallery_add,
                color: UIColors.blue,
              ),
            ),
            Text(
              "Aggiungi foto",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Row locationName() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: UIColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _nameController,
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Nome del luogo",
              hintStyle:
                  GoogleFonts.poppins(color: UIColors.grey, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.flag,
                color: UIColors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row adressName() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: UIColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _addressController,
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Indirizzo",
              hintStyle:
                  GoogleFonts.poppins(color: UIColors.grey, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.location,
                color: UIColors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row headerDesc() {
    return Row(
      children: [
        Expanded(
          child: Text(
              "Contribuisci a rendere xplore un posto vibrante. Raccomanda un nuovo posto e ricevi 200 punti.",
              overflow: TextOverflow.visible,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey)),
        )
      ],
    );
  }

  Row headerTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'Vuoi raccomandare un luogo ',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'Mite',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: UIColors.blue)),
                const TextSpan(text: '?'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _createNewLocation() {
    Map<String, dynamic> newLocationMap = {
      "name": _nameController.text,
      "desc": _descController.text,
      "indication": _indicationController.text,
      "locationCategory": categoriesBottomSheet.catSelected,
      "address": _addressController.text
    };

    log(newLocationMap.toString());

    _locationBloc.add(CreateNewLocation(map: newLocationMap));
  }

  _getFromGallery() async {
    _picker.pickImage(source: ImageSource.gallery);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        log(image.path);
        imageFile = File(image.path);
      });
    }
  }
}
