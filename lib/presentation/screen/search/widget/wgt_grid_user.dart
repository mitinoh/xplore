import 'package:flutter/material.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/presentation/screen/user/sc_user.dart';
import 'package:xplore/utils/imager.dart';

class UserGridWidget extends StatelessWidget {
  UserGridWidget({Key? key, required this.userList}) : super(key: key);
  final List<UserModel> userList;
  late ThemeData themex;

  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 30,
        color: themex.primaryColor.withOpacity(0.1),
      ),
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserScreen(userRef: userList[index], visualOnly: true)));
          },
          child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  unselectedWidgetColor: themex.disabledColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: themex.primaryColor,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ImageWidget(
                                imageUrl: Img.getUserUrl(userList[index]),
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userList[index].username ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: themex.indicatorColor),
                            ),
                            Text(
                              userList[index].bio ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: themex.disabledColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(Iconsax.arrow_right_1)
                ],
              )),
        );
      },
    );
  }
}
