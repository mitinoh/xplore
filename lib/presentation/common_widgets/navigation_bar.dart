import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xplore/presentation/router.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({Key? key, required this.indexChange}) : super(key: key);
  final Function(int index) indexChange;
  @override
  State<NavigationBarWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarWidget> {
  void _onItemTapped(int index) {
    if (selectedIndex != index) {
      widget.indexChange(index);
      /*switch (index) {
        case 0:
          Navigator.pushNamed(context, AppRouter.HOME);
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          Navigator.pushNamed(context, AppRouter.USER);
          break;
        default:
      }*/

      setState(() {
        selectedIndex = index;
      });
    }
  }

  static int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Planner'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User')
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      onTap: (index) => _onItemTapped(index),
    );
  }
}
