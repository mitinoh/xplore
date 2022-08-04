import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/go_navigation_widget.dart';
import 'package:xplore/presentation/common_widgets/like_button.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';

class PinnedMenu extends StatefulWidget {
  const PinnedMenu({Key? key, required this.locationList}) : super(key: key);
  final LocationModel locationList;

  @override
  State<PinnedMenu> createState() => _PinnedMenuState();
}

class _PinnedMenuState extends State<PinnedMenu> {
  late MediaQueryData mediaQuery;
  late ThemeData lightDark;
  late BuildContext _blocContext;
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    lightDark = Theme.of(context);
    _blocContext = context;

    return Positioned(
        bottom: mediaQuery.size.height * 0.25,
        right: 20,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: lightDark.scaffoldBackgroundColor.withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              _searchButton(),
              const SizedBox(height: 25),
              _likeButton(),
              const SizedBox(height: 25),
              _navigateButton(),
              const SizedBox(height: 15),
            ],
          ),
        ));
  }

  InkWell _navigateButton() {
    return InkWell(
        onTap: () => {
              showModalBottomSheet(
                  context: context,
                  //isScrollControlled: true,
                  useRootNavigator: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return GoNavigationBottomSheet(
                        location: widget.locationList);
                  })
            },
        child: Icon(Iconsax.discover_1, color: lightDark.primaryColor));
  }

  Widget _likeButton() {
    return LikeButton(
      locationList: widget.locationList,
    );
  }

  InkWell _searchButton() {
    return InkWell(
        onTap: () => {
              /*
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              )*/
            },
        child: Icon(Iconsax.search_normal, color: lightDark.primaryColor));
  }
}
