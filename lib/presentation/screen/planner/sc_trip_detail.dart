import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/data/model/planner_model.dart';
import 'package:xplore/data/model/trip_model.dart';
import 'package:xplore/presentation/common_widgets/detail_location_modal.dart';
import 'package:xplore/presentation/common_widgets/wg_image.dart';
import 'package:xplore/utils/imager.dart';
import 'package:geocoding/geocoding.dart';

class TripDetailScreen extends StatelessWidget {
  TripDetailScreen({Key? key, required this.planTrip}) : super(key: key);

  final PlannerModel planTrip;
  late ThemeData themex;
  late BuildContext _blocContext;

  @override
  Widget build(BuildContext context) {
    themex = Theme.of(context);
    _blocContext = context;
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Scaffold(
          backgroundColor: themex.canvasColor,
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: CustomScrollView(slivers: <Widget>[
                    _tripName(),
                    _subHeader(),
                    _locationInfo(),
                  ])))),
    );
  }

  Widget _locationInfo() {
    return SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500.0, childAspectRatio: 1.6),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return InkWell(
              onTap: () {}, child: _tripWidget(planTrip.plannedLocation?[index]));
        }, childCount: planTrip.plannedLocation?.length));
  }

  Widget _tripName() {
    return SliverAppBar(
        floating: true,
        pinned: true,
        snap: true,
        elevation: 0,
        backgroundColor: themex.canvasColor,
        leading: SizedBox(),
        leadingWidth: 23,
        title: Text(planTrip.tripName ?? '',
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w600, color: themex.primaryColor)));
  }

  Widget _subHeader() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: FutureBuilder<String>(
                      future: _getUserLocation(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: themex.disabledColor));
                        }
                        return const Text("");
                      }))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                    _getFormattedDate(planTrip.goneDate) +
                        ' - ' +
                        _getFormattedDate(planTrip.returnDate),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: themex.disabledColor)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _tripWidget(TripModel? pTrip) {
    return InkWell(
      onTap: () {
        DetailLocationModal(location: pTrip?.location ?? LocationModel(id: "_"))
            .show(_blocContext);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: themex.dividerColor),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [themex.primaryColor, themex.primaryColor]),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: themex.scaffoldBackgroundColor,
                  child: CircleAvatar(
                      radius: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ImageWidget(
                              imageUrl: Img.getLocationUrl(pTrip!.location!)))),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(pTrip.location?.name ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: themex.primaryColor)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            _meteoInfo(pTrip)
          ],
        ),
      ),
    );
  }

  Widget _meteoInfo(TripModel? pTrip) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_getFormattedDate(pTrip?.date),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w300, color: themex.indicatorColor)),
        Padding(
          padding: const EdgeInsets.only(left: 7.0),
          child: Text((_getTripVisitDay(pTrip)).toString() + "° giorno".toLowerCase(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: themex.indicatorColor)),
        ),
        /*Padding(
          padding: const EdgeInsets.only(left: 7.0),
          child: Icon(
            Iconsax.sun_1,
            size: 20,
            color: themex.indicatorColor,
          ),
        ),
        Text("23°C",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w300, color: themex.indicatorColor)),
                */
      ],
    );
  }

  int _getTripVisitDay(TripModel? pTrip) {
    DateTime? tripDate = pTrip?.date;
    int? differenceDays = tripDate?.difference(planTrip.goneDate ?? tripDate).inDays;
    return (differenceDays ?? 0) + 1;
  }

  String _getFormattedDate(DateTime? date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date ?? DateTime.now());
  }

  Future<String> _getUserLocation() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        planTrip.geometry?.coordinates?[1] ?? 0.0,
        planTrip.geometry?.coordinates?[0] ?? 0.0);
    Placemark place = placemarks[0];

    return '${place.locality}, ${place.country}';
  }
}
