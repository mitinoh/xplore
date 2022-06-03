import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/user_bloc/user_bloc_bloc.dart';
import 'package:xplore/core/UIColors.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final UserBlocBloc _userBloc = UserBlocBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),
              InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: const Icon(Iconsax.arrow_left)),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Edit profile',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                        color: UIColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: _usernameController,
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
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
                        color: UIColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: _bioController,
                      textAlign: TextAlign.start,
                      minLines: 6,
                      maxLines: 10,
                      maxLength: 144,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Bio...",
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
                      "Cambia foto profilo",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: (() => {_updateUserInfo()}),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: UIColors.lightGreen,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Salva modifiche".toUpperCase(),
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _updateUserInfo() {
    Map<String, dynamic> userData = {};
    if (_usernameController.text.trim() != "") {
      userData["name"] = _usernameController.text;
    }
    if (_bioController.text.trim() != "") {
      userData["bio"] = _bioController.text;
    }

    _userBloc.add(UpdateUserInfo(userData));

    //_locationBloc.add(CreateNewLocation(map: newLocationMap));
  }
}
