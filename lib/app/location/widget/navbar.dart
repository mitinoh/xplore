import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/location/screen/new_location_screen.dart';
import 'package:xplore/app/map/screen/map_screen.dart';
import 'package:xplore/app/plantrip/screen/plan_trip_screen.dart';
import 'package:xplore/app/user/screen/dashboard.dart';
import 'package:xplore/core/UIColors.dart';

class NavbarHome extends StatelessWidget {
  const NavbarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffF3F7FA).withOpacity(0.8)),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewLocation()),
                  )
                },
                child: Icon(Iconsax.location_add, color: UIColors.black),
              ),
              const Spacer(),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  )
                },
                child: Icon(Iconsax.map, color: UIColors.black),
              ),
              const Spacer(),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlanTripScreen()),
                  )
                },
                child: Icon(Iconsax.calendar_search, color: UIColors.black),
              ),
              const Spacer(),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserScreen()),
                  )
                },
                child: Icon(Iconsax.user, color: UIColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
