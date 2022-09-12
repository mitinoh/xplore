import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';

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
                          text: 'Impostazioni',
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: themex.disabledColor)),
                    )
                  ],
                ),
                const SizedBox(height: 30),
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
                            "Supportaci con 5 stelle",
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
                            Iconsax.happyemoji,
                            color: themex.indicatorColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Aiuto ed assistenza",
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
                            "Termini e condizioni",
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
                              "Disconnetti account",
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
                            title: const Text('Cancella account'),
                            content: const Text(
                                "Per cancellare l'account devi prima effettuare di nuovo il login e poi potrai effettuare la cancellazione"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('NO'),
                              ),
                              TextButton(
                                onPressed: () => context.read<AuthenticationBloc>()
                                //.add(DeleteAccount())
                                ,
                                child: Text('Cancella'.toUpperCase()),
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
                              "Cancella account",
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
}
