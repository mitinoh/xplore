import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Edit profile',
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
          Row(
            children: const [
              Expanded(
                child: Text(
                    "lorem ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(
                        overflow: TextOverflow.visible,
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
                  child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 5, top: 5),
                decoration: BoxDecoration(
                    color: UIColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Username",
                    hintStyle: TextStyle(color: UIColors.grey, fontSize: 14),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Iconsax.user,
                      color: UIColors.blue,
                    ),
                  ),
                  autofocus: false,
                ),
              ))
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 5, top: 5),
                decoration: BoxDecoration(
                    color: UIColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Nome utente",
                    hintStyle: TextStyle(color: UIColors.grey, fontSize: 14),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      Iconsax.user,
                      color: UIColors.blue,
                    ),
                  ),
                  autofocus: false,
                ),
              ))
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding:
                const EdgeInsets.only(left: 15, top: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: UIColors.grey.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15),
                  child: Icon(
                    Iconsax.box_2,
                    color: UIColors.blue,
                  ),
                ),
                const Text(
                  "Modifica foto",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
