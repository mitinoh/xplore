import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/screen/trophy_screen.dart';
import 'package:xplore/app/user/widgets/trophy_detail_bottom_sheet.dart';
import 'package:xplore/core/UIColors.dart';

class MainTrophyWidget extends StatelessWidget {
  const MainTrophyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 3.5),
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
                backgroundColor: UIColors.platinium,
                radius: 26,
                child: Icon(
                  Iconsax.cup,
                  color: UIColors.green,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.5),
            child: CircleAvatar(
              backgroundColor: UIColors.platinium,
              radius: 26,
              child: Icon(
                Iconsax.cup,
                color: UIColors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.5),
            child: CircleAvatar(
              backgroundColor: UIColors.platinium,
              radius: 26,
              child: Icon(
                Iconsax.lock,
                color: UIColors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.5),
            child: CircleAvatar(
              backgroundColor: UIColors.platinium,
              radius: 26,
              child: Icon(
                Iconsax.lock,
                color: UIColors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.5),
            child: CircleAvatar(
              backgroundColor: UIColors.platinium,
              radius: 26,
              child: Icon(
                Iconsax.lock,
                color: UIColors.black,
              ),
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
            child: CircleAvatar(
              backgroundColor: UIColors.blue,
              radius: 26,
              child: Text(
                "+20",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          /*InkWell(
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
                  )*/
        ],
      ),
    );
  }
}
