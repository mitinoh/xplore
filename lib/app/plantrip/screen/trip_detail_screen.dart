import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/widgets/image_tile.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
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
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(Iconsax.calendar),
                                ),
                                Text((index + 1).toString() + "°",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        IntrinsicHeight(
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      VerticalDivider(
                                        color: index == 1
                                            ? UIColors.blue
                                            : UIColors.platinium,
                                        thickness: 4,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text:
                                                'lorem ipsum is simply dummy text of the printing and typesetting industry.',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text: '\ndettaglio luogo',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                            backgroundColor: lightDark
                                                .scaffoldBackgroundColor,
                                            child: CircleAvatar(
                                                radius: 37,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://images.pexels.com/photos/2064827/pexels-photo-2064827.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        const LoadingIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Center(
                                                      child: Icon(
                                                          Iconsax.gallery_slash,
                                                          size: 30,
                                                          color: UIColors
                                                              .lightRed),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      )
                                    ]))),
                        IntrinsicHeight(
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      VerticalDivider(
                                        color: index == 1
                                            ? UIColors.blue
                                            : UIColors.platinium,
                                        thickness: 4,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text:
                                                'lorem ipsum is simply dummy text of the printing and typesetting industry.',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text: '\ndettaglio luogo',
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
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
                                            backgroundColor: lightDark
                                                .scaffoldBackgroundColor,
                                            child: CircleAvatar(
                                                radius: 37,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://images.pexels.com/photos/2225442/pexels-photo-2225442.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        const LoadingIndicator(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Center(
                                                      child: Icon(
                                                          Iconsax.gallery_slash,
                                                          size: 30,
                                                          color: UIColors
                                                              .lightRed),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      )
                                    ]))),
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
