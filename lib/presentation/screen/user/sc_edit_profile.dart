import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/subtitle.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_event.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen(
      {Key? key,
      required this.userData,
      required this.blocContext,
      this.newUser = false,
      this.callback})
      : super(key: key);

  final UserModel userData;
  final BuildContext blocContext;
  final bool newUser;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userBioController = TextEditingController();
  final VoidCallback? callback;

  late MediaQueryData mediaQueryX;
  late ThemeData themex;

  void initController() async {
    _usernameController.text = userData.username ?? '';
    _userBioController.text = userData.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryX = MediaQuery.of(context);
    themex = Theme.of(context);
    initController();
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
                backgroundColor: themex.scaffoldBackgroundColor,
                iconTheme: IconThemeData(color: themex.canvasColor),
                actionsIconTheme: IconThemeData(color: themex.canvasColor),
                leading: newUser ? SizedBox() : _backButton(context),
                leadingWidth: 23,
                title: _pageTitle(),
                actions: [
                  _saveButton(),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 10),
                  _subTitle(),
                  const SizedBox(height: 20),
                  _username(),
                  const SizedBox(height: 5),
                  _bio(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _saveButton() {
    return Center(
        child: InkWell(
      onTap: () {
        _updateUserInfo();
      },
      child: Text("Salva".toLowerCase(),
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w700, color: themex.primaryColor)),
    ));
  }

  Text _pageTitle() {
    return Text(
      "Modifica profilo",
      style: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w600, color: themex.indicatorColor),
    );
  }

  GestureDetector _backButton(BuildContext context) {
    return GestureDetector(
        onTap: () => {Navigator.pop(context)},
        child: Icon(
          Iconsax.arrow_left,
          color: themex.primaryColor,
        ));
  }

  Subtitle _subTitle() {
    return Subtitle(
        text:
            "Qui puoi cambiare il tuo username e personalizzare in base al tuo stile o alla tua personalità la tua biografia.",
        colors: themex.disabledColor);
  }

  Row _username() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _usernameController,
            maxLength: 16,
            textAlign: TextAlign.start,
            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: themex.disabledColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Username",
              hintStyle: GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.user,
                color: themex.indicatorColor,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  Widget _bio() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: themex.cardColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _userBioController,
            textAlign: TextAlign.start,
            minLines: 6,
            maxLines: 10,
            maxLength: 144,
            style: TextStyle(color: themex.indicatorColor, fontSize: 14),
            decoration: InputDecoration(
              counterStyle: TextStyle(color: themex.disabledColor),
              contentPadding: const EdgeInsets.all(15.0),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Inserisci la tua bio...",
              hintStyle: GoogleFonts.poppins(color: themex.disabledColor, fontSize: 14),
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Iconsax.brush_4,
                color: themex.indicatorColor,
              ),
            ),
            autofocus: false,
          ),
        ))
      ],
    );
  }

  void _updateUserInfo() async {
    UserModel userData =
        UserModel(username: _usernameController.text, bio: _userBioController.text);

    /*
    String? base64Image;
    if (image != null) {
      final bytes = File(image!.path).readAsBytesSync();
      base64Image = "data:image/png;base64," + base64Encode(bytes);
      userData["base64"] = base64Image;
    }
    */

    if (newUser) {
      try {
        UserBloc(userRepository: UserRepository())
          ..add(CreateNewUser(userData: userData));
        callback!();
      } catch (e) {
        print(e);
      }
      // Navigator.of(blocContext, rootNavigator: true).pushNamed(AppRouter.HOME);
    } else {
      blocContext.read<UserBloc>().add(UpdateUserData(newUserData: userData));
    }
    // Navigator.pop(_context);
  }
}
