import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/app/user/screen/edit_screen.dart';
import 'package:xplore/app/user/widgets/settings.dart';

class UserHeaderNavigation extends StatelessWidget {
  const UserHeaderNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
            child: const Icon(Iconsax.magicpen)),
        InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const SettingsBottomSheet();
                  });
            },
            child: const Icon(Iconsax.more))
      ],
    );
  }
}