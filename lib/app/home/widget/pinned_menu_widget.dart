import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/widget/go_navigation_widget.dart';
import 'package:xplore/app/search_location/screen/search_screen.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/widgets/like_btn.dart';
import 'package:xplore/model/location_model.dart';

class PinnedMenu extends StatefulWidget {
  const PinnedMenu(
      {Key? key,
      required this.locationList,
      required this.indexLocation,
      required this.locationBloc})
      : super(key: key);
  final List<LocationModel> locationList;
  final int indexLocation;
  final HomeBloc locationBloc;

  @override
  State<PinnedMenu> createState() => _PinnedMenuState();
}

class _PinnedMenuState extends State<PinnedMenu> {
  Future likeLocation() async {
    widget.locationBloc.add(SaveUserLocation(
        locationId: widget.locationList[widget.indexLocation].iId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Positioned(
        bottom: mediaQuery.size.height * 0.25,
        right: 20,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffF3F7FA).withOpacity(0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              searchBtn(context),
              const SizedBox(height: 25),
              LikeButton(
                indexLocation: widget.indexLocation,
                locationBloc: widget.locationBloc,
                locationList: widget.locationList,
              ),
              const SizedBox(height: 25),
              navigateBtn(context),
              const SizedBox(height: 15),
            ],
          ),
        ));
  }

  InkWell navigateBtn(BuildContext context) {
    return InkWell(
        onTap: () => {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return GoNavigationBottomSheet(
                        location: widget.locationList[widget.indexLocation]);
                  })
            },
        child: Icon(Iconsax.discover_1, color: UIColors.black));
  }

  InkWell saveBtn() {
    return InkWell(
      onTap: () {
        bool isSaved = widget.locationList[widget.indexLocation].saved ?? false;

        setState(() {
          widget.locationList[widget.indexLocation].saved = !isSaved;
        });

        widget.locationBloc.add(SaveUserLocation(
            locationId: widget.locationList[widget.indexLocation].iId ?? '',
            save: !isSaved));
      },
      child: Icon(Iconsax.heart,
          color: widget.locationList[widget.indexLocation].saved == true
              ? UIColors.lightRed
              : UIColors.black),
    );
  }

  InkWell searchBtn(BuildContext context) {
    return InkWell(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              )
            },
        child: Icon(Iconsax.search_normal, color: UIColors.black));
  }
}
