import 'package:flutter/material.dart';
import 'package:xplore/core/UIColors.dart';

// ignore: must_be_immutable
class FilterLocationBottomSheet extends StatelessWidget {
  const FilterLocationBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.60,
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
                  Text("Filitra location per luogo",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black)),
                ],
              ),
              Container(
                height: 550,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.only(top: 20),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: UIColors.bluelight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Mare",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Montagna",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Città",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Campagna",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Collina",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Lago",
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
