import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                elevation: 0,
                backgroundColor: lightDark.scaffoldBackgroundColor,
                iconTheme: const IconThemeData(color: Colors.black),
                actionsIconTheme: const IconThemeData(color: Colors.black),
                leading: GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: Icon(Iconsax.arrow_left,
                        color: lightDark.primaryColor)),
                leadingWidth: 23,
                title: Text(
                  "nome vacanza",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(index == 1 ? "👉 23 giugno" : "23 giugno",
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.poppins(
                                    color: lightDark.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.sun_1,
                                    color: lightDark.primaryColor,
                                  ),
                                ),
                                Text("33°",
                                    style: GoogleFonts.poppins(
                                        color: lightDark.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.calendar,
                                    color: lightDark.primaryColor,
                                  ),
                                ),
                                Text((index + 1).toString() + "°",
                                    style: GoogleFonts.poppins(
                                        color: lightDark.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IntrinsicHeight(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                  VerticalDivider(
                                    color: index == 1
                                        ? UIColors.blue
                                        : UIColors.platinium,
                                    thickness: 4,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Fontana di trevi',
                                      style: GoogleFonts.poppins(
                                          color: lightDark.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '\ndettaglio luogo',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: lightDark.primaryColor)),
                                      ],
                                    ),
                                  ),
                                ])),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff9fccfa), //f0ebc0
                                    Color(0xff0974f1), //9dddf4
                                    //e93a28
                                  ]),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      lightDark.scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                      radius: 37,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://images.pexels.com/photos/2064827/pexels-photo-2064827.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const LoadingIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                            child: Icon(Iconsax.gallery_slash,
                                                size: 30,
                                                color: UIColors.lightRed),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IntrinsicHeight(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                  VerticalDivider(
                                    color: index == 1
                                        ? UIColors.blue
                                        : UIColors.platinium,
                                    thickness: 4,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Fontana di trevi',
                                      style: GoogleFonts.poppins(
                                          color: lightDark.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '\ndettaglio luogo',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: lightDark.primaryColor)),
                                      ],
                                    ),
                                  ),
                                ])),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff9fccfa), //f0ebc0
                                    Color(0xff0974f1), //9dddf4
                                    //e93a28
                                  ]),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      lightDark.scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                      radius: 37,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://images.pexels.com/photos/2064827/pexels-photo-2064827.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const LoadingIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                            child: Icon(Iconsax.gallery_slash,
                                                size: 30,
                                                color: UIColors.lightRed),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                  childCount: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
