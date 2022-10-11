import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/data/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoNavigationBottomSheet extends StatelessWidget {
  GoNavigationBottomSheet({Key? key, required this.location}) : super(key: key);
  final LocationModel location;
  late MediaQueryData mediaQueryX;
  late ThemeData themex;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return _build(context);
        });
  }

  Widget _build(BuildContext context) {
    themex = Theme.of(context);
    mediaQueryX = MediaQuery.of(context);
    return Container(
      height: mediaQueryX.size.height * 0.45,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: themex.canvasColor,
      ),
      child: SafeArea(
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
                          text: "Let's go on a new adventure",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: themex.indicatorColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Reach unforgettable places and experiences with a simple click. We will open your favorite car navigator and we will always be here to assist you, have a nice trip.",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: themex.disabledColor)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () => {
                          context.read<HomeBloc>().add(NavigateToLocation(
                              latitude: location.geometry?.coordinates?[1] ?? 0.0,
                              longitude: location.geometry?.coordinates?[0] ?? 0.0))
                        },
                    child: ConfirmButton(
                      text: "google maps",
                      colors: themex.primaryColor,
                      colorsText: themex.canvasColor,
                    )),
              ]),
        ),
      ),
    );
  }
}
