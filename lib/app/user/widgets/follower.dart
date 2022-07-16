import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/bloc_follower/follower_bloc.dart';
import 'package:xplore/app/user/screen/dashboard.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/user_model.dart';

// ignore: must_be_immutable, camel_case_types
class FollowerBottomSheet extends StatelessWidget {
  const FollowerBottomSheet({Key? key, this.user}) : super(key: key);

  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          FollowerBloc()..add(FollowerGetListEvent(uid: user?.sId)),
      child: SafeArea(
        child: Container(
          height: mediaQuery.size.height * 0.84,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: lightDark.backgroundColor,
              appBar: TabBar(
                labelColor: lightDark.primaryColor,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: UIColors.platinium),
                indicatorWeight: 0,
                unselectedLabelColor: lightDark.primaryColor.withOpacity(0.3),
                tabs: [
                  Tab(
                      child: Text(
                    "Follower",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                  Tab(
                      child: Text(
                    "Seguiti",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
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
                                        state.followerList.followed?[index]
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => UserScreen(
                                                    visualOnly: true,
                                                    user: state
                                                        .followerList
                                                        .followed?[index]
                                                        .followed,
                                                  )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 20,
                                          left: 20,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          // color: UIColors.platinium,
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Text("visulizza profilo",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: lightDark.primaryColor)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const Text("0 seguaci");
                    },
                  ),
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => UserScreen(
                                                    visualOnly: true,
                                                    user: state
                                                        .followerList
                                                        .following?[index]
                                                        .followed,
                                                  )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 20,
                                          left: 20,
                                          top: 5,
                                          bottom: 5),
                                      decoration: BoxDecoration(
                                          // color: UIColors.platinium,
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Text("visulizza profilo",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: lightDark.primaryColor)),
                                    ),
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
