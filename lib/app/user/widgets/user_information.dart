import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/app/user/screen/trophy_screen.dart';
import 'package:xplore/app/user/widgets/follower.dart';
import 'package:xplore/app/user/widgets/trophy_detail_bottom_sheet.dart';
import 'package:xplore/core/UIColors.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: UIColors.blue,
          backgroundImage: const NetworkImage(
              'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80'),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
                future: UserRepository.getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: snapshot.data,
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: lightDark.primaryColor)));
                  }
                  return const Text("-");
                }),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: UIColors.platinium,
                    borderRadius: BorderRadius.circular(20)),
                child: Text("segui",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ),
            ), //da commentare ovviamente e scommentare solo quando daremo la possibilità che gli utenti interagiscano tra di loro
          ],
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: FutureBuilder<String>(
                      future: UserRepository.getUserBio(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: snapshot.data,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey)));
                        }
                        return const Text("-");
                      })),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return const followerBottomSheet();
                        });
                  },
                  child: Row(
                    children: [
                      Icon(Iconsax.arrow_up_3, color: lightDark.primaryColor),
                      Text(
                        "20",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: lightDark.primaryColor),
                      ),
                      Icon(Iconsax.arrow_down, color: lightDark.primaryColor),
                      Text(
                        "29",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: lightDark.primaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "la tua cerchia",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: lightDark.primaryColor),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "2",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
                Text(
                  "in programma",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: lightDark.primaryColor),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useRootNavigator: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return const TrophyDetailBottomSheet();
                          });
                    },
                    child: CircleAvatar(
                      backgroundColor: UIColors.violetMain,
                      radius: 28,
                      child: Icon(
                        Iconsax.crown_1,
                        color: UIColors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.orange,
                    radius: 28,
                    child: const Icon(Iconsax.crown_1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.yellow,
                    radius: 28,
                    child: const Icon(Iconsax.crown),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.platinium,
                    radius: 28,
                    child: const Icon(Iconsax.crown),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrophyRoomScreen()),
                    );
                  },
                  child: Text(
                    "+20 more",
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: lightDark.primaryColor),
                  ),
                )
              ],
            ),
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TrophyRoomScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  //color: UIColors.blue,
                  border: Border.all(width: 1, color: UIColors.grey),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  // border: Border.all(width: 1, color: UIColors.grey)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.cup, color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Trophy room lv.4".toUpperCase(),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),*/
      ],
    );
  }
}
