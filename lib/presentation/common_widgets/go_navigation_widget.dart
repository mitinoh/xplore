import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xplore/model/model/location_model.dart';
import 'package:xplore/presentation/common_widgets/confirm_button.dart';
import 'package:xplore/presentation/screen/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class GoNavigationBottomSheet extends StatelessWidget {
  GoNavigationBottomSheet({Key? key, required this.location}) : super(key: key);
  final LocationModel location;
  late MediaQueryData _mediaQuery;
  late ThemeData _lightDark;

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _lightDark = Theme.of(context);
    return Container(
      height: _mediaQuery.size.height * 0.45,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: _lightDark.backgroundColor,
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
                          text: 'Raggiungi luogo',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _lightDark.primaryColor),
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
                          "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry. Versione app 1.0.1",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () => {
                          context.read<HomeBloc>().add(
                              NavigateToLocation(
                                  latitude:
                                      location.geometry?.coordinates?[1] ?? 0.0,
                                  longitude:
                                      location.geometry?.coordinates?[0] ??
                                          0.0))
                        },
                    child: ConfirmButton(
                      text: "Raggiungi con google maps",
                      colors: Colors.white,
                      colorsText: Colors.green,
                    )),
              ]),
        ),
      ),
    );
  }
}