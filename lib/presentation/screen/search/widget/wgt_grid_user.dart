import 'package:flutter/material.dart';
import 'package:xplore/model/model/user_model.dart';

class UserGridWidget extends StatelessWidget {
  UserGridWidget({Key? key, required this.userList}) : super(key: key);
  final List<UserModel> userList;

  @override
  Widget build(BuildContext context) {
    return Text("user list");
    //  Config conf = Config();
    /*
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 30,
        color: _lightDark.primaryColor.withOpacity(0.1),
      ),
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        // TODO: da rifare con un metodo che ritorna tutto questo e non uno alla volta

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => UserScreen(
                          visualOnly: true,
                          user: userList[index],
                        )));
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
                          backgroundColor: UIColors.bluelight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: conf.getLocationImageUrl(
                                  userList[index].sId ?? ''),
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
                                    size: 20, color: UIColors.lightblue),
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
                              userList[index].name ?? '',
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
                                  color: UIColors.lightblue),
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
    */
  }
}
