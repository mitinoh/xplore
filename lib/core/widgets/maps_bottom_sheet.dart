import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MapsBottomSheet extends StatelessWidget {
  const MapsBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var lightDark = Theme.of(context);
    return SafeArea(
      child: Container(
        height: mediaQuery.size.height * 0.78,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const Text("qui ci sarà la mappa")]),
        ),
      ),
    );
  }
}
