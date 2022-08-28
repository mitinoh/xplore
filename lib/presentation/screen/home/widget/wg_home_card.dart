import 'package:flutter/material.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/presentation/screen/home/widget/wg_detail_menu.dart';
import 'package:xplore/presentation/screen/home/widget/wg_pinned_menu.dart';
import 'package:xplore/utils/imager.dart';

class HomeMainCard extends StatefulWidget {
  const HomeMainCard({
    Key? key,
    required this.locationsList,
  }) : super(key: key);
  final List<LocationModel> locationsList;

  @override
  State<HomeMainCard> createState() => _HomeMainCardState();
}

class _HomeMainCardState extends State<HomeMainCard> {
  final PageController pageController = PageController();
  late MediaQueryData mediaQuery;
  late ThemeData lightDark;

  bool _showPinnedMenu = true;
  int _lastIndexLocation = 0;
  int _indexLocation = 0;


  toggleDetail() {
    setState(() {
      _showPinnedMenu = !_showPinnedMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    lightDark = Theme.of(context);
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
        expanded: !_showPinnedMenu,
        location: widget.locationsList[_indexLocation],
        toggle: toggleDetail);
  }

  Widget _header() {
    return Positioned(
        top: mediaQuery.size.height * 0.1,
        left: 20,
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
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
                    color: lightDark.scaffoldBackgroundColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                    widget.locationsList.isNotEmpty
                        ? //widget.model[_indexLocation].insertUid?.name ??
                        '@xplore'
                        : '@xplore',
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: lightDark.primaryColor)),
              ),
            ),
          ],
        ));
  }

  Widget _pinnedMenu() {
    return Visibility(
      visible: _showPinnedMenu,
      child: PinnedMenu(
        locationList: widget.locationsList[_indexLocation]
      )
    );
  }

  PageView _listPageView() {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: _getCardsImages(),
      onPageChanged: (i) => {
        _changeIndexLocation(i)
      },
    );
  }

  List<Widget> _getCardsImages() {
    List<Widget> cards = [];
    for (LocationModel location in widget.locationsList) {
      cards.add(
        ImageWidget(imageUrl: Img.getLocationUrl(location))
      );
    }
    return cards;
  }

  _changeIndexLocation(int i) {
    setState(() {
      _indexLocation = i;
    });

    if (_indexLocation > _lastIndexLocation && i % 15 == 0) {
      // HomeRepository.skip += 15; // TODO: cambiare 15 in modo dyn
      //widget.locationBloc.add(const GetLocationList());
    }

    if (_indexLocation > _lastIndexLocation) {
      _lastIndexLocation = _indexLocation;
    }
  }
}
