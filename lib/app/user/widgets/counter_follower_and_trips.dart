import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/bloc_follower_count/follower_count_bloc.dart';
import 'package:xplore/app/user/widgets/follower.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/user_model.dart';

class CounterFollowerAndTrips extends StatelessWidget {
  const CounterFollowerAndTrips({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocProvider(
              create: (context) => FollowerCountBloc()
                ..add(FollowerGetCountListEvent(uid: user?.sId)),
              child: BlocBuilder<FollowerCountBloc, FollowerCountState>(
                builder: (context, state) {
                  if (state is FollowerCountLoadedState) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            backgroundColor: lightDark.backgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            builder: (context) {
                              return FollowerBottomSheet(
                                user: user,
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0, left: 4),
                            child: Icon(Iconsax.arrow_up_1,
                                color: UIColors.lightblue),
                          ),
                          Text(
                            state.followerCount.followed.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: lightDark.primaryColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0, left: 4),
                            child: Icon(Iconsax.arrow_down_2,
                                color: UIColors.lightblue),
                          ),
                          Text(
                            state.followerCount.following.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: lightDark.primaryColor),
                          ),
                        ],
                      ),
                    );
                  }
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0, left: 4),
                        child:
                            Icon(Iconsax.arrow_up_1, color: UIColors.bluelight),
                      ),
                      Text(
                        "0",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: lightDark.primaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0, left: 4),
                        child: Icon(Iconsax.arrow_down_2,
                            color: UIColors.bluelight),
                      ),
                      Text(
                        "0",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: lightDark.primaryColor),
                      ),
                    ],
                  );
                },
              ),
            ),
            Text(
              "la tua cerchia",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: lightDark.primaryColor),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 4),
                  child: Icon(Iconsax.note, color: UIColors.lightblue),
                ),
                Text(
                  "3",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: lightDark.primaryColor),
                ),
              ],
            ),
            Text(
              "in programma",
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: lightDark.primaryColor),
            ),
          ],
        )
      ],
    );
  }
}
