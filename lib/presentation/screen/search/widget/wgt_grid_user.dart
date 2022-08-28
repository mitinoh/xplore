import 'package:flutter/material.dart';
import 'package:xplore/data/model/user_model.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:xplore/presentation/common_widgets/widget_loading_indicator.dart';
import 'package:xplore/presentation/screen/user/sc_user.dart';

class UserGridWidget extends StatelessWidget {
  UserGridWidget({Key? key, required this.userList}) : super(key: key);
  final List<UserModel> userList;
  late ThemeData _lightDark;

  @override
  Widget build(BuildContext context) {
    _lightDark = Theme.of(context);
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 30,
        color: _lightDark.primaryColor.withOpacity(0.1),
      ),
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserScreen(
                        userRef: userList[index], visualOnly: true)));
          },
          child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  unselectedWidgetColor: Colors.grey.withOpacity(0.3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.lightBlue,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://107.174.186.223.nip.io/img/user/62f4ba41bb478cf097896970.jpg",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const LoadingIndicator(),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Iconsax.gallery_slash,
                                    size: 20, color: Colors.lightBlue),
                              ),
                            ),
                          )),
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
                                  color: _lightDark.primaryColor),
                            ),
                            Text(
                              "LV. 1",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue),
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
