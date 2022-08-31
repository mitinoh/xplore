import 'package:flutter/material.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/presentation/screen/home/widget/wg_detail_menu.dart';
import 'package:xplore/presentation/screen/home/widget/wg_pinned_menu.dart';
import 'package:xplore/utils/imager.dart';

class HomeMainCard extends StatefulWidget {
  const HomeMainCard({
    Key? key,
    required this.locationList,
  }) : super(key: key);
  final List<LocationModel> locationList;

  @override
  State<HomeMainCard> createState() => _HomeMainCardState();
}

class _HomeMainCardState extends State<HomeMainCard> {
  final PageController pageController = PageController();

  bool _pinnedMenuVisible = true;
  int _lastIdxLocation = 0;
  int _currentIdx = 0;

  toggleDetail() {
    setState(() {
      _pinnedMenuVisible = !_pinnedMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listPageView(),
        _pinnedMenu(),
        _header(),
        _detailMenu(),
      ],
    );
  }

  Widget _detailMenu() {
    return DetailMenuWidget(
        expanded: !_pinnedMenuVisible,
        location: location,
        toggleDetailMenu: toggleDetail);
  }

  Widget _header() {
    return Positioned(
        top: App.mediaQueryX.size.height * 0.1,
        left: 20,
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // TODO: fare redirect
                /* if (widget.model[_indexLocation].insertUid != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => UserScreen(
                                visualOnly: true,
                                user: widget.model[_indexLocation].insertUid,
                              )));
                }*/
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: App.themex.scaffoldBackgroundColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(locationName,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: App.themex.primaryColor,
                    )),
              ),
            ),
          ],
        ));
  }

  Widget _pinnedMenu() {
    return Visibility(
        visible: _pinnedMenuVisible,
        child: PinnedMenu(
          location: location,
        ));
  }

  PageView _listPageView() {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: _getCardsImages(),
      onPageChanged: (i) => {_changeIndexLocation(i)},
    );
  }

  List<Widget> _getCardsImages() {
    List<Widget> cards = [];
    for (LocationModel location in widget.locationList) {
      cards.add(ImageWidget(imageUrl: Img.getLocationUrl(location)));
    }
    return cards;
  }

  void _changeIndexLocation(int i) {
    setState(() {
      _currentIdx = i;
    });

    if (_currentIdx > _lastIdxLocation && i % 15 == 0) {
      // HomeRepository.skip += 15; // TODO: cambiare 15 in modo dyn
      //widget.locationBloc.add(const GetLocationList());
    }

    if (_currentIdx > _lastIdxLocation) {
      _lastIdxLocation = _currentIdx;
    }
  }

  LocationModel get location {
    return widget.locationList[_currentIdx];
  }

  String get locationName {
    return widget.locationList[_currentIdx].insertUid?.username ?? '@xplore';
  }
}
