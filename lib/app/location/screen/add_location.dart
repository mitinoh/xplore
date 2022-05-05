import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xplore/core/UIColors.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: const Icon(Iconsax.arrow_left))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Vuoi raccomandare un luogo ',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Mite',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: UIColors.violet)),
                          const TextSpan(text: '?'),
                        ],
                      ),
                    ),
                  ),
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
                        hintText: "Nome un posto",
                        hintStyle:
                            TextStyle(color: UIColors.grey, fontSize: 14),
                        border: const OutlineInputBorder(),
                        suffixIconColor: UIColors.violet,
                        prefixIcon: Icon(
                          Iconsax.note_add,
                          color: UIColors.violet,
                        ),
                      ),
                      autofocus: false,
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, top: 20, right: 20, bottom: 20),
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
                        color: UIColors.violet,
                      ),
                    ),
                    Text(
                      "Aggiugni foto",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                      minLines: 6,
                      maxLines: 10,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Breve descrizione",
                        hintStyle:
                            TextStyle(color: UIColors.grey, fontSize: 14),
                        border: const OutlineInputBorder(),
                        suffixIconColor: UIColors.violet,
                        prefixIcon: Icon(
                          Iconsax.note,
                          color: UIColors.violet,
                        ),
                      ),
                      autofocus: false,
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
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
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIColors.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Iconsax.add,
                    ),
                    Text(
                      "Salva".toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
