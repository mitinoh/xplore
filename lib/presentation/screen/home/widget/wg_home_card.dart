import 'package:flutter/material.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:xplore/presentation/screen/home/widget/wg_detail_menu.dart';
import 'package:xplore/presentation/screen/home/widget/wg_pinned_menu.dart';
import 'package:xplore/presentation/screen/user/sc_user.dart';
import 'package:xplore/utils/imager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late MediaQueryData mediaQueryX = MediaQuery.of(context);
  late ThemeData themex = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildListPageView(),
        _buildPinnedMenu(),
        _buildHeader(),
        _buildDetailMenu(),
      ],
    );
  }

  Widget _buildDetailMenu() => DetailMenuWidget(
      expanded: !_pinnedMenuVisible, location: location, toggleDetailMenu: _toggleDetail);

  Widget _buildHeader() => Positioned(
      top: mediaQueryX.size.height * 0.1,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _onNameTab();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: themex.scaffoldBackgroundColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(locationName,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themex.indicatorColor,
                  )),
            ),
          ),
        ],
      ));

  Widget _buildPinnedMenu() => Visibility(
      visible: _pinnedMenuVisible,
      child: PinnedMenu(
        location: location,
      ));

  PageView _buildListPageView() => PageView(
        scrollDirection: Axis.vertical,
        controller: pageController,
        children: _buildCardsImages(),
        onPageChanged: (i) => {_changeIndexLocation(i)},
      );

  List<Widget> _buildCardsImages() {
    List<Widget> _cardImages = [];
    widget.locationList.forEach((location) =>
        _cardImages.add(ImageWidget(imageUrl: Img.getLocationUrl(location))));
    return _cardImages;
  }

  LocationModel get location {
    return widget.locationList[_currentIdx];
  }

  String get locationName {
    return widget.locationList[_currentIdx].uid?.username ?? '@xplore';
  }

  void _toggleDetail() {
    setState(() {
      _pinnedMenuVisible = !_pinnedMenuVisible;
    });
  }

  void _changeIndexLocation(int i) {
    setState(() {
      _currentIdx = i;
    });

    if (_currentIdx > _lastIdxLocation && i % 15 == 0) {
      // HomeRepository.skip += 15; // TODO: cambiare 15 in modo dyn
      BlocProvider.of<HomeBloc>(context)..add(const GetLocationList());
    }

    if (_currentIdx > _lastIdxLocation) {
      _lastIdxLocation = _currentIdx;
    }
  }

  void _onNameTab() {
    if (location.uid != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserScreen(userRef: location.uid, visualOnly: true)));
    }
  }
}
