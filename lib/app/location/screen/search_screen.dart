import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:xplore/core/UIColors.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late bool _valore = false;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => {Navigator.pop(context)},
                      child: const Icon(Iconsax.arrow_left)),
                  InkWell(onTap: () => {}, child: const Icon(Iconsax.setting_4))
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
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (hasFocus) {
                          // do stuff
                          setState(() {
                            _valore = true;
                          });
                        } else {
                          setState(() {
                            _valore = false;
                          });
                        }
                      },
                      child: TextFormField(
                        controller: _searchController,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "cerca un posto",
                          hintStyle:
                              TextStyle(color: UIColors.grey, fontSize: 14),
                          border: const OutlineInputBorder(),
                          suffixIconColor: UIColors.violet,
                          prefixIcon: IconButton(
                            icon: Icon(
                              Iconsax.search_normal,
                              color: UIColors.violet,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              /*
                                      //LocationRepository.skip = 1;
                                      widget.homeBloc.add(GetLocationList(
                        searchName: _searchController.text.toString(),
                        add: false));
                        */
                            },
                          ),
                        ),
                        autofocus: false,
                      ),
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _valore,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Roma",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Bologna",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Genova",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Milano",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: UIColors.bluelight,
                          ),
                          const Text(
                            "Barcellona",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                          const Icon(Iconsax.arrow_right_1)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !_valore,
                child: Row(
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.only(right: 10.0, top: 20, bottom: 15),
                      child: Text(
                        "Posti suggeriti",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !_valore,
                child: SizedBox(
                  child: MasonryGrid(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    column: 2,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              SizedBox(
                                height: 150,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              SizedBox(
                                height: 200,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              SizedBox(
                                height: 200,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: UIColors.bluelight,
                            borderRadius: BorderRadius.circular(20)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "luogo",
                                  overflow: TextOverflow.visible,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
