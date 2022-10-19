import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class LockTripBottomSheet extends StatelessWidget {
  LockTripBottomSheet({
    Key? key,
  }) : super(key: key);


  late MediaQueryData mediaQueryX ;
  late ThemeData themex;
  @override
  Widget build(BuildContext context) {

  mediaQueryX = MediaQuery.of(context);
  themex = Theme.of(context);
    return Container(
      height: mediaQueryX.size.height * 0.65,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: themex.backgroundColor,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.purpleAccent,
                child: const Icon(
                  Iconsax.lock,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nome vacanza",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: themex.primaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.yellow, borderRadius: BorderRadius.circular(20)),
                      child: Text("in corso...",
                          style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.green)),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Il giorno ",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: themex.primaryColor),
                      children: <TextSpan>[
                        const TextSpan(
                            text: "21-07-2022",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              //decoration: TextDecoration.underline,
                            )),
                        TextSpan(
                            text: " hai pianificato una vacanza di ",
                            style: TextStyle(
                              color: themex.primaryColor,
                            )),
                        const TextSpan(
                          text: "n",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                            text: " giorni a ",
                            style: TextStyle(
                              color: themex.primaryColor,
                            )),
                        const TextSpan(
                          text: "Barcellona",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Questa vacanza è stata programmata, sarà disponibile quando sarà in corso.",
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.yellow),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.edit),
                        ),
                        Text(
                          "Modifica",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                      thickness: 2,
                      color: themex.scaffoldBackgroundColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          ),
                        ),
                        Text(
                          "Cancella",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
