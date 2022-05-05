import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class GoNavigationBottomSheet extends StatelessWidget {
  const GoNavigationBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.30,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
                children: const [
                  Text("Vuoi raggiungere il luogo desiderito?",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black)),
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
                  children: const [
                    Text(
                      "Raggiungi su google maps",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Iconsax.arrow_right_1,
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
