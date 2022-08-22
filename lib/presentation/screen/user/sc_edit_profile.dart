import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/model/user_model.dart';
import 'package:xplore/presentation/common_widgets/subtitle.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_event.dart';
import 'package:xplore/utils/pref.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen(
      {Key? key, required this.userData, required this.blocContext})
      : super(key: key);

  final UserModel userData;
  final BuildContext blocContext;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userBioController = TextEditingController();
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  Pref pref = Pref();



  void initState() async {
    _usernameController.text = userData.username ?? '';
    _userBioController.text = userData.bio ?? '';
  }

  late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
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
                  "Modifica profilo",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
                actions: [
                  Center(
                      child: InkWell(
                    onTap: () {
                      _updateUserInfo();
                    },
                    child: Text("Salva".toLowerCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue)),
                  )),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Subtitle(
                          text:
                              "Qui puoi cambiare il tuo username e personalizzare in base al tuo stile o alla tua personalità la tua biografia.",
                          colors: Colors.grey),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                                color: lightDark.cardColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              controller: _usernameController,
                              maxLength: 16,
                              textAlign: TextAlign.start,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                counterStyle: TextStyle(
                                    color: lightDark.unselectedWidgetColor),
                                contentPadding: const EdgeInsets.all(15.0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Username",
                                hintStyle: GoogleFonts.poppins(
                                    color: lightDark.unselectedWidgetColor,
                                    fontSize: 14),
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Iconsax.user,
                                  color: Colors.blue,
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
                                color: lightDark.cardColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              controller: _userBioController,
                              textAlign: TextAlign.start,
                              minLines: 6,
                              maxLines: 10,
                              maxLength: 144,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              decoration: InputDecoration(
                                counterStyle: TextStyle(
                                    color: lightDark.unselectedWidgetColor),
                                contentPadding: const EdgeInsets.all(15.0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Inserisci la tua bio...",
                                hintStyle: GoogleFonts.poppins(
                                    color: lightDark.unselectedWidgetColor,
                                    fontSize: 14),
                                border: const OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Iconsax.brush_4,
                                  color: Colors.blue,
                                ),
                              ),
                              autofocus: false,
                            ),
                          ))
                        ],
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
    UserModel userData = UserModel(
        username: _usernameController.text, bio: _userBioController.text);

    /*
    String? base64Image;
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
      userData["base64"] = base64Image;
    }
    */

    blocContext.read<UserBloc>().add(UpdateUserData(newUserData: userData));
    //BlocProvider.of<UserBloc>(_blocContext)..add(UpdateUserData(newUserData: userData));

    Navigator.pop(_context);
  }
}
