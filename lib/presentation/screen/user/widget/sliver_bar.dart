import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/model/model/user_model.dart';

class SliverBarWidget extends StatelessWidget {
  SliverBarWidget({Key? key, this.user}) : super(key: key);
  final UserModel? user;
  late ThemeData _lightDark;

  @override
  Widget build(BuildContext context) {
    _lightDark = Theme.of(context);
    return SliverAppBar(
        floating: true,
        pinned: true,
        snap: true,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: _lightDark.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: _lightDark.primaryColor),
        actionsIconTheme: IconThemeData(color: _lightDark.primaryColor),
        leading: GestureDetector(
            onTap: () => {
                  /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctz) => EditProfile(
                                  context: context,
                                )),
                      )*/
                },
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(Iconsax.user_edit),
            )),
        leadingWidth: 44,
        title: Text(user?.username ?? ' ... ',
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _lightDark.primaryColor)),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useRootNavigator: true,
                  backgroundColor: _lightDark.backgroundColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  builder: (context) {
                    return user == null
                        ? Text("setting bottom sheet")
                        : Text("report bottom sheet");
                    //return const SettingsBottomSheet();
                  });
            },
            child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: user == null
                    ? Icon(Iconsax.setting_2)
                    : Icon(Iconsax.flag)),
          )
        ]);
  }
}
