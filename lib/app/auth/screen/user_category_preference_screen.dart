import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/user/screen/category_preference.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/subtitle.dart';

class UserCategoryPreferenceScreen extends StatelessWidget {
  UserCategoryPreferenceScreen({Key? key, required this.context})
      : super(key: key);
  final BuildContext context;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  @override
  Widget build(context) {
    var lightDark = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                elevation: 0,
                centerTitle: false,
                titleSpacing: 0,
                automaticallyImplyLeading: false,
                backgroundColor: lightDark.scaffoldBackgroundColor,
                iconTheme: IconThemeData(color: lightDark.primaryColor),
                title: Text(
                  "Crea il tuo profilo",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: lightDark.primaryColor),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        NewUser(_usernameController.text, _bioController.text,
                            CategoryPreference.catSelected),
                      );
                      /*
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );*/
                    },
                    child: Icon(Iconsax.arrow_right_1,
                        color: lightDark.primaryColor),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Subtitle(
                      text: "Prenditi un momento per creare il tuo profilo.",
                      colors: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: const Icon(Iconsax.image),
                              backgroundColor: UIColors.bluelight,
                            ),
                            Positioned(
                                bottom: -15,
                                left: 50,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    //qui si scatena l'evento del caricamento
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: UIColors.bluelight,
                                      child: const Icon(
                                        Iconsax.add,
                                        color: Colors.black,
                                      )),
                                ))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Subtitle(
                      text:
                          "Dopo aver scelto la foto profilo, scegli il tuo username con il quale il mondo di xplore ti conoscerà e scoprirà.",
                      colors: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                              color: lightDark.cardColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            controller: _usernameController,
                            maxLength: 18,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: lightDark.hoverColor, fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Scegli un username",
                              hintStyle: GoogleFonts.poppins(
                                  color: lightDark.unselectedWidgetColor,
                                  fontSize: 14),
                              border: const OutlineInputBorder(),
                              prefixIcon: Icon(
                                Iconsax.user,
                                color: UIColors.mainColor,
                              ),
                            ),
                            autofocus: false,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                              color: lightDark.cardColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            controller: _bioController,
                            minLines: 6,
                            maxLines: 10,
                            maxLength: 144,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: lightDark.hoverColor, fontSize: 14),
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
                                color: UIColors.mainColor,
                              ),
                            ),
                            autofocus: false,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Subtitle(
                      text:
                          "Selezioni gli argomenti di maggior interesse per te.",
                      colors: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return const CategoryPreference();
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
