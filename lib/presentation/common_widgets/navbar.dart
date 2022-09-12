import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/presentation/screen/home/sc_home.dart';
import 'package:xplore/presentation/screen/map/screen/sc_map.dart';
import 'package:xplore/presentation/screen/new_location/new_location_screen.dart';
import 'package:xplore/presentation/screen/planner/sc_planner.dart';
import 'package:xplore/presentation/screen/user/sc_user.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class Navbar extends StatelessWidget {
  Navbar({Key? key}) : super(key: key);

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  late ThemeData themex;
  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: themex.canvasColor, // Default is Colors.white.
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
      navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const MapScreen(),
      const NewLocation(),
      PlannerScreen(),
      UserScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.discover),
        iconSize: 25,
        title: ("Home"),
        activeColorPrimary: themex.primaryColor,
        inactiveColorPrimary: themex.disabledColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.map),
        title: ("Map"),
        iconSize: 25,
        activeColorPrimary: themex.primaryColor,
        inactiveColorPrimary: themex.disabledColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.location_add),
        title: ("Add"),
        iconSize: 25,
        activeColorPrimary: themex.primaryColor,
        inactiveColorPrimary: themex.disabledColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.calendar_search),
        title: ("Trip"),
        iconSize: 25,
        activeColorPrimary: themex.primaryColor,
        inactiveColorPrimary: themex.disabledColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Iconsax.user),
        title: ("Profile"),
        iconSize: 25,
        activeColorPrimary: themex.primaryColor,
        inactiveColorPrimary: themex.disabledColor,
      ),
    ];
  }
}
