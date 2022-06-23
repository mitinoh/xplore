import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/app/user/user_bloc/user_bloc_bloc.dart';
import 'package:xplore/core/UIColors.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final UserBlocBloc _userBloc = UserBlocBloc();

  XFile? image;
  final ImagePicker _picker = ImagePicker();

  _getFromGallery() async {
    // _picker.pickImage(source: ImageSource.gallery);
    image = await _picker.pickImage(source: ImageSource.gallery);
    /*
    String base64Image = "";
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
      log(base64Image.toString());
    }*/
  }

  void initState() async {
    _usernameController.text = await UserRepository.getUserName();
    _bioController.text = await UserRepository.getUserBio();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    var lightDark = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                elevation: 0,
                backgroundColor: lightDark.scaffoldBackgroundColor,
                iconTheme: const IconThemeData(color: Colors.black),
                actionsIconTheme: const IconThemeData(color: Colors.black),
                leading: GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: Icon(
                      Iconsax.arrow_left,
                      color: lightDark.primaryColor,
                    )),
                leadingWidth: 23,
                title: Text(
                  "Edit profile",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
                actions: [
                  InkWell(
                    onTap: (() => {_updateUserInfo()}),
                    child: Icon(
                      Icons.done,
                      color: lightDark.primaryColor,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
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
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                                color: lightDark.backgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              controller: _usernameController,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: lightDark.primaryColorDark,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15.0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Username",
                                hintStyle: GoogleFonts.poppins(
                                    color: UIColors.grey, fontSize: 14),
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Iconsax.user,
                                  color: UIColors.blue,
                                ),
                              ),
                              autofocus: false,
                            ),
                          ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                                color: lightDark.backgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              controller: _bioController,
                              textAlign: TextAlign.start,
                              minLines: 6,
                              maxLines: 10,
                              maxLength: 144,
                              style: TextStyle(
                                  color: lightDark.primaryColorDark,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15.0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Inserisci la tua bio...",
                                hintStyle: GoogleFonts.poppins(
                                    color: UIColors.grey, fontSize: 14),
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Iconsax.brush_4,
                                  color: UIColors.blue,
                                ),
                              ),
                              autofocus: false,
                            ),
                          ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: lightDark.backgroundColor,
                        ),
                        child: InkWell(
                          onTap: (() {
                            _getFromGallery();
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15.0, left: 15),
                                child: Icon(
                                  Iconsax.gallery_add,
                                  color: UIColors.blue,
                                ),
                              ),
                              Text(
                                "Cambia foto profilo",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: lightDark.primaryColorDark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = {};
    if (_usernameController.text.trim() != "") {
      userData["name"] = _usernameController.text;
      prefs.setString("userName", _usernameController.text);
    }
    if (_bioController.text.trim() != "") {
      userData["bio"] = _bioController.text;
      prefs.setString("userBio", _bioController.text);
    }
    String? base64Image;
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
      userData["base64"] = base64Image;
    }

    _userBloc.add(UpdateUserInfo(userData));

    //_locationBloc.add(CreateNewLocation(map: newLocationMap));
  }
}
