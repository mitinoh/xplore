import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/router.dart';
import 'package:xplore/presentation/screen/user/widget/bs_report.dart';
import 'package:xplore/presentation/screen/user/widget/bs_settings.dart';

class SliverBarWidget extends StatelessWidget {
  SliverBarWidget({Key? key, required this.user, this.visualOnly = false})
      : super(key: key);
  final UserModel user;
  final bool visualOnly;
  final ThemeData themex = App.themex;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return SliverAppBar(
        floating: true,
        pinned: true,
        snap: true,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: themex.scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: themex.primaryColor),
        actionsIconTheme: IconThemeData(color: themex.primaryColor),
        leading: _editUser(),
        leadingWidth: 44,
        title: _usernameTitle(),
        actions: [_topRightButton()]);
  }

  GestureDetector _editUser() {
    return GestureDetector(
        onTap: () => {
              Navigator.of(_buildContext, rootNavigator: true).pushNamed(
                  AppRouter.EDITUSER,
                  arguments: {"user": user, "context": _buildContext})
            },
        child: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Iconsax.user_edit),
        ));
  }

  Text _usernameTitle() {
    return Text(user.username ?? ' ... ',
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.w600, color: themex.primaryColor));
  }

  InkWell _topRightButton() {
    return InkWell(
      onTap: () {
        _showBottomSheet();
      },
      child: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: visualOnly ? Icon(Iconsax.flag) : Icon(Iconsax.setting)),
    );
  }

  Future<dynamic> _showBottomSheet() {
    return showModalBottomSheet(
        context: _buildContext,
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: themex.backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return visualOnly ? ReportBottomSheet(user: user) : const SettingsBottomSheet();
        });
  }
}
