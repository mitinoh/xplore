import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/bs_navigation.dart';
import 'package:xplore/presentation/common_widgets/like_button.dart';
import 'package:xplore/presentation/router.dart';

class PinnedMenu extends StatefulWidget {
  PinnedMenu({Key? key, required this.location}) : super(key: key);
  final LocationModel location;

  @override
  State<PinnedMenu> createState() => _PinnedMenuState();
}

class _PinnedMenuState extends State<PinnedMenu> {
  late MediaQueryData mediaQueryX = MediaQuery.of(context);
  late ThemeData themex = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return _buildPinnedMenu();
  }

  Positioned _buildPinnedMenu() => Positioned(
      bottom: mediaQueryX.size.height * 0.25,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themex.scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            _buildSearchButton(),
            const SizedBox(height: 25),
            _buildLikeButton(),
            const SizedBox(height: 25),
            _buildNavigateButton(),
            const SizedBox(height: 15),
          ],
        ),
      ));

  InkWell _buildNavigateButton() => InkWell(
      onTap: () => {_showNavigationBottomSheet()},
      child: Icon(Iconsax.discover_1, color: themex.disabledColor));

  Widget _buildLikeButton() => LikeButton(location: widget.location);

  InkWell _buildSearchButton() => InkWell(
      onTap: () =>
          {Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.SEARCH)},
      child: Icon(Iconsax.search_normal, color: themex.disabledColor));

  void _showNavigationBottomSheet() =>
      GoNavigationBottomSheet(location: widget.location).show(context);
}
