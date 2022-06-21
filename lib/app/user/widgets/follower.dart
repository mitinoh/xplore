import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class followerBottomSheet extends StatelessWidget {
  const followerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.43,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color(0xffF3F7FA),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.black.withOpacity(0.2),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  backgroundImage: const NetworkImage(
                                      'https://i.pinimg.com/originals/5b/82/29/5b8229fd30350305dc3545846f2c8f65.jpg'),
                                )),
                            Text(
                              "madison_beer",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "visulizza profilo",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
                        const EdgeInsets.only(top: 20.0, left: 5, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(),
                            ),
                            Text(
                              "artenismolla",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "visulizza profilo",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }
}
