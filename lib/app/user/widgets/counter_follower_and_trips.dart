import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/bloc_follower_count/follower_count_bloc.dart';
import 'package:xplore/app/user/widgets/follower.dart';
import 'package:xplore/core/UIColors.dart';

class CounterFollowerAndTrips extends StatelessWidget {
  const CounterFollowerAndTrips({Key? key}) : super(key: key);

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
              create: (context) =>
                  FollowerCountBloc()..add(FollowerGetCountListEvent()),
              child: BlocBuilder<FollowerCountBloc, FollowerCountState>(
                builder: (context, state) {
                  if (state is FollowerCountLoadedState) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const followerBottomSheet();
                            });
                      },
                      child: Row(
                        children: [
                          Icon(Iconsax.arrow_up_3,
                              color: lightDark.primaryColor),
                          Text(
                            state.followerCount.followed.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: lightDark.primaryColor),
                          ),
                          Icon(Iconsax.arrow_down,
                              color: lightDark.primaryColor),
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
                      Icon(Iconsax.arrow_up_3, color: lightDark.primaryColor),
                      Text(
                        "0",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: lightDark.primaryColor),
                      ),
                      Icon(Iconsax.arrow_down, color: lightDark.primaryColor),
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
            Text(
              "0",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: lightDark.primaryColor),
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
