import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/home/bloc/home_bloc.dart';
import 'package:xplore/app/home/repository/home_repository.dart';
import 'package:xplore/app/home/widget/pinned_menu_widget.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/core/config.dart';
import 'package:xplore/model/location_model.dart';

class BuildMainCard extends StatefulWidget {
  const BuildMainCard(
      {Key? key,
      required this.pageController,
      required this.model,
      required this.locationBloc})
      : super(key: key);
  final PageController pageController;
  final List<Location> model;
  final HomeBloc locationBloc;

  @override
  State<BuildMainCard> createState() => _BuildMainCardState();
}

class _BuildMainCardState extends State<BuildMainCard> {
  Config conf = Config();
  List<Widget> cards = [];
  List<Location> locations = [];
  double _height = 85;
  bool _showPinnedMenu = true;
  int _lastIndexLocation = 0;
  int _indexLocation = 0;

  @override
  void initState() {
    getCards();
    super.initState();
  }

  setDetailMenuHeight() {
    setState(() {
      _height = _showPinnedMenu ? 340 : 85;
      _showPinnedMenu = !_showPinnedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        listPageView(),
        pinnedMenu(),
        header(mediaQuery),
        detailMenu(),
      ],
    );
  }

  Positioned detailMenu() {
    return Positioned(
      child: Column(
        children: [
          AnimatedContainer(
            height: _height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF3F7FA).withOpacity(0.8)),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            duration: const Duration(seconds: 1),
            curve: Curves.bounceOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    textScaleFactor: 1,
                    text: TextSpan(
                        text: widget.model[_indexLocation].name.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        children: [
                          TextSpan(
                              text: ", " +
                                  widget.model[_indexLocation].desc.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () => {setDetailMenuHeight()},
                  child: _showPinnedMenu
                      ? const Icon(Iconsax.maximize_4)
                      : Icon(Iconsax.close_circle, color: UIColors.black),
                )
              ],
            ),
          ),
        ],
      ),
      bottom: 0,
      right: 0,
      left: 0,
    );
  }

  Positioned header(MediaQueryData mediaQuery) {
    return Positioned(
        top: mediaQuery.size.height * 0.1,
        left: 20,
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xffF3F7FA).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                  widget.model[_indexLocation].insertUid?.name ?? '@xplore',
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
          ],
        ));
  }

  Visibility pinnedMenu() {
    return Visibility(
      visible: _showPinnedMenu,
      child: PinnedMenu(
        locationList: widget.model,
        indexLocation: _indexLocation,
        locationBloc: widget.locationBloc,
      ),
    );
  }

  PageView listPageView() {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: widget.pageController,
      children: cards,
      onPageChanged: (i) => {
        changeIndexLocation(i),
      },
    );
  }

  getCards() {
    locations.addAll(widget.model);
    for (Location el in widget.model) {
      cards.add(
        CachedNetworkImage(
          imageUrl: conf.getLocationImageUrl(el.iId ?? ''),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Icon(Iconsax.gallery_remove),
        ),
        /*DecorationImage(
                image: NetworkImage(conf.getLocationImageUrl(el.iId ?? '')),
                fit: BoxFit.cover,
                onError: (obj, stackTrace) => {})*/
      );
    }
  }

  changeIndexLocation(int i) {
    setState(() {
      _indexLocation = i;
    });

    // TODO: controllare che funzioni davvero
    if (_indexLocation > _lastIndexLocation && i % 15 == 0) {
      HomeRepository.skip += 15; // TODO: cambiare 15 in modo dyn
      widget.locationBloc.add(const GetLocationList());
    }

    if (_indexLocation > _lastIndexLocation) {
      _lastIndexLocation = _indexLocation;
    }
  }
}
