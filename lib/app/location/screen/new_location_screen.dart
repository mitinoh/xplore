import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'dart:io';

import 'package:xplore/model/locationCategory_model.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({Key? key}) : super(key: key);
  @override
  State<NewLocation> createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final LocationcategoryBloc _locCatBloc = LocationcategoryBloc();

  final LocationBloc _locationBloc = LocationBloc();
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
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () => {Navigator.pop(context)},
                        child: const Icon(Iconsax.arrow_left))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Vuoi raccomandare un luogo ',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Mite',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: UIColors.violet)),
                            const TextSpan(text: '?'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 5, top: 5),
                      decoration: BoxDecoration(
                          color: UIColors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: _nameController,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Nome un posto",
                          hintStyle:
                              TextStyle(color: UIColors.grey, fontSize: 14),
                          border: const OutlineInputBorder(),
                          suffixIconColor: UIColors.violet,
                          prefixIcon: Icon(
                            Iconsax.note_add,
                            color: UIColors.violet,
                          ),
                        ),
                        autofocus: false,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 20, right: 20, bottom: 20),
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
                            color: UIColors.violet,
                          ),
                        ),
                        const Text(
                          "Aggiugni foto",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 5, top: 5),
                      decoration: BoxDecoration(
                          color: UIColors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: _descController,
                        textAlign: TextAlign.start,
                        minLines: 6,
                        maxLines: 10,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Breve descrizione",
                          hintStyle:
                              TextStyle(color: UIColors.grey, fontSize: 14),
                          border: const OutlineInputBorder(),
                          suffixIconColor: UIColors.violet,
                          prefixIcon: Icon(
                            Iconsax.note,
                            color: UIColors.violet,
                          ),
                        ),
                        autofocus: false,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocProvider(
                  create: (_) => _locCatBloc,
                  child:
                      BlocListener<LocationcategoryBloc, LocationcategoryState>(
                    listener: (context, state) {
                      if (state is LocationError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("error"),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<LocationcategoryBloc,
                        LocationcategoryState>(
                      builder: (context, state) {
                        if (state is LocationcategoryInitial ||
                            state is LocationCategoryLoading) {
                          return const LoadingIndicator();
                        } else if (state is LocationcategoryLoaded) {
                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.locationCategoryModel.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // TODO: da rifare con un metodo che ritorna tutto questo e non uno alla volta
                                    return CheckboxListTile(
                                      value: _categoryIsSelected(
                                          state.locationCategoryModel, index),
                                      onChanged: (bln) {
                                        _toggleSelectedCat(
                                            state.locationCategoryModel, index);
                                      },
                                      title: Text(_getLocationName(
                                          state.locationCategoryModel, index)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        } else if (state is LocationcategoryError) {
                          return Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
