import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/bloc_follower/follower_bloc.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';

// ignore: must_be_immutable, camel_case_types
class followerBottomSheet extends StatelessWidget {
  const followerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);

    return BlocProvider(
      create: (context) => FollowerBloc()..add(const FollowerGetListEvent()),
      child: Container(
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
                  BlocBuilder<FollowerBloc, FollowerState>(
                    builder: (context, state) {
                      if (state is FollowerLoadedState) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.followerList.following?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  UIColors.bluelight,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://www.nickiswift.com/img/gallery/what-you-dont-know-about-madison-beers-virtual-idol-career/intro-1606938484.jpg',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      const LoadingIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                    child: Icon(
                                                        Iconsax.gallery_slash,
                                                        size: 30,
                                                        color:
                                                            UIColors.lightRed),
                                                  ),
                                                ),
                                              ))),
                                      Text(
                                        state.followerList.following?[index]
                                                .followed?.name ??
                                            "",
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
                                            color:
                                                Colors.grey.withOpacity(0.3)),
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
                        );
                      }
                      return Container(
                        child: Text("0 seguaci"),
                      );
                    },
                  ),
                  BlocBuilder<FollowerBloc, FollowerState>(
                    builder: (context, state) {
                      if (state is FollowerLoadedState) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.followerList.followed?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 0, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor:
                                                  UIColors.bluelight,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://www.nickiswift.com/img/gallery/what-you-dont-know-about-madison-beers-virtual-idol-career/intro-1606938484.jpg',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      const LoadingIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                    child: Icon(
                                                        Iconsax.gallery_slash,
                                                        size: 30,
                                                        color:
                                                            UIColors.lightRed),
                                                  ),
                                                ),
                                              ))),
                                      Text(
                                        state.followerList.followed?[index].uid
                                                ?.name ??
                                            "",
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
                                            color:
                                                Colors.grey.withOpacity(0.3)),
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
                        );
                      }
                      return Container(
                        child: Text("0 seguiti"),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
