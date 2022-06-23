import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class followerBottomSheet extends StatelessWidget {
  const followerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);

    return Container(
      height: mediaQuery.size.height * 0.54,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: lightDark.backgroundColor,
      ),
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: lightDark.backgroundColor,
            appBar: TabBar(
              labelColor: lightDark.primaryColor,
              indicatorColor: lightDark.primaryColor,
              indicatorWeight: 1,
              unselectedLabelColor: lightDark.primaryColor.withOpacity(0.2),
              tabs: [
                Tab(
                    icon: Text(
                  "Follower",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                Tab(
                    icon: Text(
                  "Seguiti",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ],
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundImage: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZl7DaWMSexxDHWARgwp2ncCprSz1yV4Q_Rg&usqp=CAU'),
                                  )),
                              Text(
                                "madison_beer",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: lightDark.primaryColor),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                // color: UIColors.platinium,
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(0)),
                            child: Text("visulizza profilo",
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: lightDark.primaryColor)),
                          )
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 10, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 22,
                                ),
                              ),
                              Text(
                                "artenismolla",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: lightDark.primaryColor),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                // color: UIColors.platinium,
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(0)),
                            child: Text("visulizza profilo",
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: lightDark.primaryColor)),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
