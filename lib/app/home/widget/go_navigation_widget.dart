import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/map/repository/map_repository.dart';
import 'package:xplore/core/UIColors.dart';
import 'package:xplore/model/location_model.dart';

// ignore: must_be_immutable
class GoNavigationBottomSheet extends StatelessWidget {
  GoNavigationBottomSheet({Key? key, required this.location}) : super(key: key);
  final LocationModel location;
  final MapRepository _mapRepository = MapRepository();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.22,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color(0xffF3F7FA),
      ),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Vuoi raggiungere il luogo ',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'desiderato',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: UIColors.blue)),
                          const TextSpan(text: '?'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () => {
                              _mapRepository.openMap(
                                  location.coordinate?.lat ?? 0.0,
                                  location.coordinate?.lng ?? 0.0)
                            },
                        child: Text(
                          "Raggiungi su google maps",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        )),
                    const Icon(Iconsax.routing)
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
