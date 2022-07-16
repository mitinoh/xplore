import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/bloc_follower/follower_bloc.dart';
import 'package:xplore/app/user/repository/user_repository.dart';
import 'package:xplore/app/user/screen/trophy_screen.dart';
import 'package:xplore/app/user/user_bloc/user_bloc_bloc.dart';
import 'package:xplore/app/user/widgets/counter_follower_and_trips.dart';
import 'package:xplore/app/user/widgets/trophy_detail_bottom_sheet.dart';
import 'package:xplore/app/user/widgets/trophy_widgets.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/widget_core.dart';
import 'package:xplore/model/user_model.dart';

// ignore: must_be_immutable
class UserInformation extends StatefulWidget {
  UserInformation(
      {Key? key, required this.context, this.user, required this.visualOnly})
      : super(key: key);
  final BuildContext context;
  final UserModel? user;
  final bool visualOnly;

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<String> _userBio = UserRepository.getUserBio();
  Future<String> _userName = UserRepository.getUserName();

  bool followState = false;

  @override
  void initState() {
    if (widget.user != null) {
      _userBio = Future.value(widget.user?.bio ?? "");
      _userName = Future.value(widget.user?.name ?? "");
      followState = widget.user?.following ?? false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    var lightDark = Theme.of(context);
    return BlocListener<UserBlocBloc, UserBlocState>(
      listener: (context, state) {
        if (state is UpdatedUserInfo) {
          _userBio = UserRepository.getUserBio();
          _userName = UserRepository.getUserName();
        }
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: UIColors.bluelight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const LoadingIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Iconsax.gallery_slash,
                            size: 30, color: UIColors.lightRed),
                      ),
                    ),
                  )),
              !widget.visualOnly
                  ? Positioned(
                      //questo tasto sarà visibile solo quando si visuelezzarà il profilo di un altro utente
                      bottom: -15,
                      left: 50,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          //qui si scatena l'evento del caricamento
                        },
                        child: CircleAvatar(
                            backgroundColor: UIColors.platinium,
                            child: Icon(
                              Iconsax.add,
                              color: UIColors.mainColor,
                            )),
                      ))
                  : const SizedBox()
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<String>(
                  future: _userName,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: snapshot.data.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: lightDark.primaryColor)),
                            TextSpan(
                                text: ' LV. 1',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff3498db)))
                          ],
                        ),
                      );
                    }
                    return const Text("-");
                  }),
              if (widget.visualOnly)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (followState) {
                        FollowerBloc()
                          ..add(FollowerUnfollowUserEvent(
                              uid: widget.user?.sId ?? ''));
                      } else {
                        FollowerBloc()
                          ..add(FollowerFollowUserEvent(
                              uid: widget.user?.sId ?? ''));
                      }
                      setState(() {
                        // TODO : fare questo con un event handler in base a cosa ritorna backend
                        followState = !followState;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: UIColors.platinium,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(!followState ? "follow" : "following",
                          style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: !followState
                                  ? Colors.black
                                  : UIColors.green)),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          const SizedBox(height: 15),
          const MainTrophyWidget(),
          const SizedBox(height: 15),
          CounterFollowerAndTrips(user: widget.user),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: FutureBuilder<String>(
                        future: _userBio,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "La tuo biografia:\n".toUpperCase() +
                                      snapshot.data.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ]),
                            );
                          }
                          return const Text("-");
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
class UserInformation extends StatelessWidget {
  UserInformation(
      {Key? key, required this.context, this.user, required this.visualOnly})
      : super(key: key);
  final BuildContext context;
  final UserModel? user;
  final bool visualOnly;

  Future<String> _userBio = UserRepository.getUserBio();
  Future<String> _userName = UserRepository.getUserName();

  bool followState = false;

  @override
  Widget build(BuildContext ctx) {
    if (user != null) {
      _userBio = Future.value(user?.bio ?? "");
      _userName = Future.value(user?.name ?? "");
      followState = user?.following ?? false;
    }
    var lightDark = Theme.of(context);
    return BlocListener<UserBlocBloc, UserBlocState>(
      listener: (context, state) {
        if (state is UpdatedUserInfo) {
          _userBio = UserRepository.getUserBio();
          _userName = UserRepository.getUserName();
        }
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: UIColors.bluelight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const LoadingIndicator(),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Iconsax.gallery_slash,
                            size: 30, color: UIColors.lightRed),
                      ),
                    ),
                  )),
              !visualOnly
                  ? Positioned(
                      //questo tasto sarà visibile solo quando si visuelezzarà il profilo di un altro utente
                      bottom: -15,
                      left: 50,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          //qui si scatena l'evento del caricamento
                        },
                        child: CircleAvatar(
                            backgroundColor: UIColors.platinium,
                            child: Icon(
                              Iconsax.add,
                              color: UIColors.mainColor,
                            )),
                      ))
                  : const SizedBox()
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<String>(
                  future: _userName,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: snapshot.data.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: lightDark.primaryColor)),
                            TextSpan(
                                text: ' LV. 1',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff3498db)))
                          ],
                        ),
                      );
                    }
                    return const Text("-");
                  }),
              if (visualOnly)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (followState) {
                        FollowerBloc()
                          ..add(FollowerFollowUserEvent(uid: user?.sId ?? ''));
                      } else {
                        FollowerBloc()
                          ..add(
                              FollowerUnfollowUserEvent(uid: user?.sId ?? ''));
                      }
                      //qui cambierà stato quando l'utente iniziare a seguire qualcuno
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: UIColors.platinium,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(!followState ? "follow" : "following",
                          style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: !followState
                                  ? Colors.black
                                  : UIColors.green)),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          const SizedBox(height: 15),
          const MainTrophyWidget(),
          const SizedBox(height: 15),
          CounterFollowerAndTrips(user: user),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: FutureBuilder<String>(
                        future: _userBio,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "La tuo biografia:\n".toUpperCase() +
                                      snapshot.data.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ]),
                            );
                          }
                          return const Text("-");
                        })),
              ],
            ),
          ),

          /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrophyRoomScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      //color: UIColors.blue,
                      border: Border.all(width: 1, color: UIColors.grey),
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      // border: Border.all(width: 1, color: UIColors.grey)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.cup, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Trophy room lv.4".toUpperCase(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),*/
        ],
      ),
    );
  }
}

*/