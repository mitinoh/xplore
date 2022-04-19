import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
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
  final List<int> _catSelected = [];

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
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              //  decoration: InputDecoration(border: InputBorder.none),
            ),
            TextFormField(
              controller: _descController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.black),
              //  decoration: InputDecoration(border: InputBorder.none),
            ),
            RaisedButton(
              color: Colors.greenAccent,
              onPressed: () {
                _getFromGallery();
              },
              child: Text("PICK FROM GALLERY"),
            ),
            BlocProvider(
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
                      return SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.locationCategoryModel.length,
                              itemBuilder: (BuildContext context, int index) {
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
            TextButton(
                onPressed: () {
                  _createNewLocation();
                },
                child: Text("add"))
          ],
        ),
      ),
    );
  }

  bool _categoryIsSelected(
      List<LocationCategory> locationCategoryModel, int index) {
    return _catSelected.contains(locationCategoryModel[index].value);
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
      int value = locationCategoryModel[index].value ?? 0;
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
