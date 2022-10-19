import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/presentation/common_widgets/sb_error.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryX = MediaQuery.of(context);
    ThemeData themex = Theme.of(context);
    return SafeArea(
      child: Container(
        height: mediaQueryX.size.height * 0.84,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Settings',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: themex.indicatorColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: themex.backgroundColor,
                          child: Icon(
                            Iconsax.star,
                            color: themex.indicatorColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Support us with 5 start",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: themex.indicatorColor),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: themex.indicatorColor.withOpacity(0.1),
                    ),
                    InkWell(
                      onTap: (() {
                        _openEmail(context);
                      }),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: themex.backgroundColor,
                            child: Icon(
                              Iconsax.happyemoji,
                              color: themex.indicatorColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Help and assistance",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: themex.indicatorColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 30,
                      color: themex.indicatorColor.withOpacity(0.1),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: themex.backgroundColor,
                          child: Icon(
                            Iconsax.shield,
                            color: themex.indicatorColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Privacy policy",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: themex.indicatorColor),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: themex.indicatorColor.withOpacity(0.1),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: themex.backgroundColor,
                          child: Icon(
                            Iconsax.note_2,
                            color: themex.indicatorColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Terms and conditions",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: themex.indicatorColor),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: themex.indicatorColor.withOpacity(0.1),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: themex.backgroundColor,
                          child: Icon(
                            Iconsax.logout,
                            color: themex.indicatorColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                LoggedOut(),
                              );
                            },
                            child: Text(
                              "Disconnect account",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: themex.indicatorColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      color: themex.indicatorColor.withOpacity(0.1),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: themex.backgroundColor,
                            title: Text('Delete account',
                                style: GoogleFonts.poppins(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w600,
                                    color: themex.indicatorColor)),
                            content: Text(
                                "We are sorry to see you go 🙁 \nAre you sure you want to continue?",
                                style: GoogleFonts.poppins(
                                    fontSize: 14.5, color: themex.indicatorColor)),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: Text('NO',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: themex.primaryColor)),
                              ),
                              TextButton(
                                onPressed: () => context
                                    .read<AuthenticationBloc>()
                                    .add(DeleteAccountRequested()),
                                child: Text('yes'.toUpperCase(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: themex.primaryColor)),
                              ),
                            ],
                          ),
                        );
                        //context.read<AuthBloc>().add(DeleteAccount());
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: themex.backgroundColor,
                            child: Icon(
                              Iconsax.profile_delete,
                              color: themex.indicatorColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Delete account",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: themex.indicatorColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  _openEmail(BuildContext context) async {
    final Uri _url = Uri.parse('mailto:beyondx.team@gmail.com?subject=xplore help&body=');

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      SbError().show(context);
    }
  }
}
