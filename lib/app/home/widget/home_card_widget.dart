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
  final List<LocationModel> model;
  final HomeBloc locationBloc;

  @override
  State<BuildMainCard> createState() => _BuildMainCardState();
}

class _BuildMainCardState extends State<BuildMainCard> {
  Config conf = Config();
  List<Widget> cards = [];
  List<LocationModel> locations = [];
  double _height = 82;
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
      _height = _showPinnedMenu ? 340 : 82;
      _showPinnedMenu = !_showPinnedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    return Stack(
      children: [
        listPageView(),
        pinnedMenu(),
        header(mediaQuery, lightDark),
        detailMenu(lightDark),
      ],
    );
  }

  Positioned detailMenu(lightDark) {
    return Positioned(
      child: AnimatedContainer(
        height: _height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: lightDark.scaffoldBackgroundColor.withOpacity(0.8)),
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 24),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        duration: const Duration(seconds: 1),
        curve: Curves.bounceOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: RichText(
                  textScaleFactor: 1,
                  text: TextSpan(
                      text: widget.model[_indexLocation].name.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: lightDark.primaryColor),
                      children: [
                        TextSpan(
                            text: ", " +
                                widget.model[_indexLocation].desc
                                    .toString()
                                    .toLowerCase(),
                            style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w300,
                                color: lightDark.primaryColor)),
                        TextSpan(
                            text:
                                "\n\nQui ci sarà la parte dei consigli su come raggiungere il luogo e altri piccoli consigli.",
                            style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w300,
                                color: lightDark.primaryColor)),
                        TextSpan(
                            text: "\n\n#mare #italy #ladolcevita #estate",
                            style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                color: lightDark.primaryColor)),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: InkWell(
                onTap: () => {setDetailMenuHeight()},
                child: _showPinnedMenu
                    ? Icon(Iconsax.maximize_4, color: lightDark.primaryColor)
                    : Icon(Icons.close, color: lightDark.primaryColor),
              ),
            )
          ],
        ),
      ),
      bottom: 0,
      right: 0,
      left: 0,
    );
  }

  Positioned header(MediaQueryData mediaQuery, lightDark) {
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
                  color: lightDark.scaffoldBackgroundColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                  widget.model[_indexLocation].insertUid?.name ?? '@xplore',
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: lightDark.primaryColor)),
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
        context: context,
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
    for (LocationModel el in widget.model) {
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

    if (_indexLocation > _lastIndexLocation && i % 15 == 0) {
      HomeRepository.skip += 15; // TODO: cambiare 15 in modo dyn
      widget.locationBloc.add(const GetLocationList());
    }

    if (_indexLocation > _lastIndexLocation) {
      _lastIndexLocation = _indexLocation;
    }
  }
}
