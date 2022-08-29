import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/data/model/location_category_model.dart';
import 'package:xplore/presentation/common_widgets/header_name.dart';
import 'package:xplore/presentation/screen/new_location/widgets/category_bottom_sheet.dart';
import 'package:xplore/presentation/screen/new_location/widgets/image_imported.dart';
import 'package:xplore/presentation/screen/search/widget/mdl_category.dart';

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
  List<LocationCategoryModel> _selectedCategories = [];
  //final LocationCategoryBloc _locCatBloc = LocationCategoryBloc();

  // final HomeBloc _locationBloc = HomeBloc();

  XFile? image;

  final ImagePicker _picker = ImagePicker();
  // late CategoriesBottomSheet categoriesBottomSheet;
  @override
  void initState() {
    //  categoriesBottomSheet = CategoriesBottomSheet(locCatBloc: _locCatBloc);
    // _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                headerTitle(),
                const SizedBox(
                  height: 20,
                ),
                headerDesc(),
                const SizedBox(height: 20),
                locationName(lightDark),
                const SizedBox(
                  height: 5,
                ),
                adressName(lightDark),
                const SizedBox(
                  height: 5,
                ),
                locationImage(lightDark),
                image != null
                    ? ImageImported(
                        path: image != null ? image!.path : '',
                      )
                    : const SizedBox(), //qui bro ci
                const SizedBox(
                  height: 5,
                ),
                locationDesc(lightDark),
                const SizedBox(
                  height: 5,
                ),
                locationCategories(lightDark),
                //locationCategories(),
                const SizedBox(
                  height: 20,
                ),
                footer(),
                const SizedBox(
                  height: 20,
                ),
                locationTips(lightDark),
                const SizedBox(
                  height: 20,
                ),
                addLocationBtn(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell locationCategories(lightDark) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              //return Text("bottom sheet categories");
              return CategoriesBottomSheet(
                  selectedCategories: _selectedCategories,
                  callback: _setSelectedCategories);
            });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightDark.cardColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15),
              child: Icon(
                Iconsax.hashtag,
                color: Colors.blue,
              ),
            ),
            Text(
              _selectedCategories.isEmpty
                  ? "Aggiungi categoria"
                  : _getSelectedCategoriesName(),
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 14, color: lightDark.hoverColor),
            ),
          ],
        ),
      ),
    );
  }

  String _getSelectedCategoriesName() {
    String categories = '';
    _selectedCategories.forEach((c) => categories += '${c.name}, ');
    return categories;
  }

  InkWell addLocationBtn() {
    return InkWell(
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
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
        )
      ],
    );
  }

  Row locationDesc(lightDark) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: lightDark.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _descController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 288,
            style: TextStyle(color: lightDark.hoverColor, fontSize: 14),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: lightDark.unselectedWidgetColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Breve descrizione del luogo che vuoi raccomandare...",
              hintStyle: GoogleFonts.poppins(
                  color: lightDark.unselectedWidgetColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.note,
                color: Colors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row locationTips(lightDark) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: lightDark.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _indicationController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 144,
            style: TextStyle(color: lightDark.hoverColor, fontSize: 14),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: lightDark.unselectedWidgetColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText:
                  "Breve tips su come raggiungiere il luogo o in quale stagione lo consogli...",
              hintStyle: GoogleFonts.poppins(
                  color: lightDark.unselectedWidgetColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.lamp_on,
                color: Colors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  InkWell locationImage(lightDark) {
    return InkWell(
      onTap: () {
        _getFromGallery();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: lightDark.cardColor),
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
                  fontWeight: FontWeight.bold, fontSize: 14, color: lightDark.hoverColor),
            ),
          ],
        ),
      ),
    );
  }

  Row locationName(lightDark) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: lightDark.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _nameController,
            maxLength: 90,
            textAlign: TextAlign.start,
            style: TextStyle(color: lightDark.hoverColor, fontSize: 14),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: lightDark.unselectedWidgetColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Nome del luogo",
              hintStyle: GoogleFonts.poppins(
                  color: lightDark.unselectedWidgetColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.flag,
                color: Colors.blue,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Row adressName(lightDark) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: lightDark.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _addressController,
            textAlign: TextAlign.start,
            style: TextStyle(color: lightDark.hoverColor, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Indirizzo luogo",
              hintStyle: GoogleFonts.poppins(
                  color: lightDark.unselectedWidgetColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.location,
                color: Colors.blue,
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
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
        )
      ],
    );
  }

  Row headerTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [HeaderName(message: "Vuoi suggerirci un posto ", questionMark: true)],
    );
  }

  void _createNewLocation() {
    String? base64Image;
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
    }
    Map<String, dynamic> newLocationMap = {
      "name": _nameController.text,
      "desc": _descController.text,
      "indication": _indicationController.text,
      "address": _addressController.text,
      "base64": base64Image, // FIXME: questo è null provare su device rl
      "locationCategory": _selectedCategories
    };

    bool allValueValid = true;
    newLocationMap.forEach((k, v) => {
          if (!validateField(v)) {allValueValid = false}
        });

    if (allValueValid) {
      //  _locationBloc.add(CreateNewLocation(map: newLocationMap));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
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

  _setSelectedCategories(List<LocationCategoryModel> categoriesList) {
    setState(() {
      _selectedCategories = categoriesList;
    });
  }

  _getFromGallery() async {
    // _picker.pickImage(source: ImageSource.gallery);

    XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null)
      setState(() {
        image = img;
      });

    /*
    String base64Image = "";
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
      log(base64Image.toString());
    }*/
  }
}
