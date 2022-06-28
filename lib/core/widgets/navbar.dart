import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:xplore/app/add_location/screen/new_location_screen.dart';
import 'package:xplore/app/home/screen/home_screen.dart';
import 'package:xplore/app/map/screen/map_screen.dart';
import 'package:xplore/app/plantrip/screen/plan_trip_screen.dart';
import 'package:xplore/app/user/bloc_saved_location/saved_location_bloc.dart';
import 'package:xplore/app/user/screen/dashboard.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    var lightDark = Theme.of(context);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      onItemSelected: (int i) {
        if (i == 4) UserScreen.refreshLocations();
      },
      items: _navBarsItems(lightDark),
      confineInSafeArea: true,
      backgroundColor:
          lightDark.scaffoldBackgroundColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const MapScreen(),
      const NewLocation(),
      const PlanTripScreen(),
      const UserScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(lightDark) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.home_1),
        iconSize: 22,
        title: ("Home"),
        activeColorPrimary: UIColors.blue,
        inactiveColorPrimary: lightDark.primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.map),
        title: ("Map"),
        iconSize: 22,
        activeColorPrimary: UIColors.blue,
        inactiveColorPrimary: lightDark.primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.location_add),
        title: ("Add"),
        iconSize: 22,
        activeColorPrimary: UIColors.blue,
        inactiveColorPrimary: lightDark.primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.calendar_search),
        title: ("Trip"),
        iconSize: 22,
        activeColorPrimary: UIColors.blue,
        inactiveColorPrimary: lightDark.primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.user),
        title: ("Profile"),
        iconSize: 22,
        activeColorPrimary: UIColors.blue,
        inactiveColorPrimary: lightDark.primaryColor,
      ),
    ];
  }
}
