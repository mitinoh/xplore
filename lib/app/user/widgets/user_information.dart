import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/screen/trophy_screen.dart';
import 'package:xplore/core/UIColors.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          children: [
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'mite.g',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                    TextSpan(
                        text: ' LV. 4',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: UIColors.blue))
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'perché i limiti, come le paure, sono spesso solo un illusione.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "29",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Text(
                  "post visitati",
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "2",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Text(
                  "in programma",
                  style: GoogleFonts.poppins(),
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
                  child: CircleAvatar(
                    backgroundColor: UIColors.lightPurple,
                    radius: 28,
                    child: Icon(Iconsax.crown_1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.orange,
                    radius: 28,
                    child: Icon(Iconsax.crown_1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.yellow,
                    radius: 28,
                    child: Icon(Iconsax.crown),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: UIColors.platinium,
                    radius: 28,
                    child: Icon(Iconsax.crown),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrophyRoomScreen()),
                    );
                  },
                  child: Text(
                    "+20 more",
                    style: GoogleFonts.poppins(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
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
