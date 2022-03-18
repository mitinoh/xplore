import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xplore/app/location/bloc/location_bloc.dart';
import 'package:xplore/app/location_category/bloc/locationcategory_bloc.dart';
import 'package:xplore/core/widget/widget_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  List<int> _catSelected = [];

  late File imageFile;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    _locCatBloc.add(GetLocationCategoryList());
    super.initState();
  }

  /// Get from gallery
  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        log(image.path);
      });
    }
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
                  if (state is HomeError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("error"),
                      ),
                    );
                  }
                },
                child: BlocBuilder<LocationcategoryBloc, LocationcategoryState>(
                  builder: (context, state) {
                    if (state is LocationcategoryInitial) {
                      return LoadingIndicator();
                    } else if (state is LocationCategoryLoading) {
                      return LoadingIndicator();
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
                                return CheckboxListTile(
                                  value: _catSelected.contains(
                                      state.locationCategoryModel[index].value),
                                  onChanged: (bln) {
                                    setState(() {
                                      int value = state
                                              .locationCategoryModel[index]
                                              .value ??
                                          0;
                                      if (_catSelected.contains(value)) {
                                        _catSelected.remove(value);
                                      } else {
                                        _catSelected.add(value);
                                      }
                                    });
                                  },
                                  title: Text(
                                      state.locationCategoryModel[index].name ??
                                          ''),
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
                  Map<String, dynamic> a = {
                    "name": _nameController.value,
                    "desc": _descController.value,
                    "categories": _catSelected
                  };

                  _locationBloc.add(CreateNewLocation(body: a.toString()));
                },
                child: Text("add"))
          ],
        ),
      ),
    );
  }
}
