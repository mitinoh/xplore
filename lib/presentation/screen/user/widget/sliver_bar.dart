import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/presentation/router.dart';
import 'package:xplore/presentation/screen/user/widget/report_bottom_sheet.dart';
import 'package:xplore/presentation/screen/user/widget/settings.dart';

class SliverBarWidget extends StatelessWidget {
  SliverBarWidget({Key? key, required this.user, required this.visualOnly})
      : super(key: key);
  final UserModel user;
  final bool visualOnly;
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
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRouter.EDITUSER,
                      arguments: {"user": user, "context": context})
                },
            child: const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Icon(Iconsax.user_edit),
            )),
        leadingWidth: 44,
        title: Text(user.username ?? ' ... ',
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
                    return visualOnly
                        ? ReportBottomSheet(user: user)
                        : const SettingsBottomSheet();
                  });
            },
            child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: visualOnly ? Icon(Iconsax.flag) : Icon(Iconsax.setting)),
          )
        ]);
  }
}