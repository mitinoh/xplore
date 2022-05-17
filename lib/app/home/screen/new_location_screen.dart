import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'dart:io';

import 'package:xplore/model/location_category_model.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({Key? key}) : super(key: key);
  @override
  State<NewLocation> createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();

  final HomeBloc _locationBloc = HomeBloc();
  final List<String> _catSelected = [];

  late File imageFile;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
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
                  height: 20,
                ),
                locationImage(),
                const SizedBox(
                  height: 20,
                ),
                locationDesc(),
                const SizedBox(
                  height: 20,
                ),
                footer(),
                const SizedBox(
                  height: 50,
                ),
                locationCategories(),
                addLocationBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocProvider<LocationcategoryBloc> locationCategories() {
    return BlocProvider(
      create: (_) => _locCatBloc,
      child: BlocListener<LocationcategoryBloc, LocationcategoryState>(
        listener: (context, state) {
          if (state is LocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("error"),
              ),
            );
          }
        },
        child: BlocBuilder<LocationcategoryBloc, LocationcategoryState>(
          builder: (context, state) {
            if (state is LocationcategoryInitial ||
                state is LocationCategoryLoading) {
              return const LoadingIndicator();
            } else if (state is LocationcategoryLoaded) {
              return locationCategoriesList(state);
            } else if (state is LocationcategoryError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView locationCategoriesList(LocationcategoryLoaded state) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.locationCategoryModel.length,
            itemBuilder: (BuildContext context, int index) {
              // TODO: da rifare con un metodo che ritorna tutto questo e non uno alla volta
              return CheckboxListTile(
                value: _categoryIsSelected(state.locationCategoryModel, index),
                onChanged: (bln) {
                  _toggleSelectedCat(state.locationCategoryModel, index);
                },
                title:
                    Text(_getLocationName(state.locationCategoryModel, index)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              );
            },
          )
        ],
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
            const Icon(
              Iconsax.add,
            ),
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
              "lorem ipsum is simply dummy text of the printing and typesetting industry.",
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
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Breve descrizione...",
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
                Iconsax.box_2,
                color: UIColors.blue,
              ),
            ),
            Text(
              "Aggiugni foto",
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
              hintText: "Nome un posto",
              hintStyle:
                  GoogleFonts.poppins(color: UIColors.grey, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.note_add,
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
              "lorem ipsum is simply dummy text of the printing and typesetting industry.",
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

  bool _categoryIsSelected(
      List<LocationCategory> locationCategoryModel, int index) {
    return _catSelected.contains(locationCategoryModel[index].iId);
  }

  String _getLocationName(
      List<LocationCategory> locationCategoryModel, int index) {
    return locationCategoryModel[index].name ?? '';
  }

  void _createNewLocation() {
    Map<String, dynamic> newLocationMap = {
      "name": _nameController.text,
      "desc": _descController.text,
      "categories": _catSelected
    };

    _locationBloc.add(CreateNewLocation(map: newLocationMap));
  }

  void _toggleSelectedCat(
      List<LocationCategory> locationCategoryModel, int index) {
    setState(() {
      String value = locationCategoryModel[index].iId ?? '';
      if (_catSelected.contains(value)) {
        _catSelected.remove(value);
      } else {
        _catSelected.add(value);
      }
    });
  }

  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }
}
