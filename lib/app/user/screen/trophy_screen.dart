import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class TrophyRoomScreen extends StatelessWidget {
  const TrophyRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                InkWell(
                    onTap: () => {Navigator.pop(context)},
                    child: const Icon(Iconsax.arrow_left)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "300 punti LV.4",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250.0,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Iconsax.crown_1,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "obbiettivo",
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0% su 100%",
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                );
              },
              childCount: 12,
            ),
          ),
        ],
      ),
    )

            /*SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: const Icon(Iconsax.arrow_left)),
              Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "300 punti LV.4",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                        overflow: TextOverflow.visible,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey)),
                  )
                ],
              ),
            ],
          ),
        ))*/
            ));
  }
}
