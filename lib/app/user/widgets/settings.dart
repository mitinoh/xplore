import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.75,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Settings',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ]),
      ),
    );
  }
}
