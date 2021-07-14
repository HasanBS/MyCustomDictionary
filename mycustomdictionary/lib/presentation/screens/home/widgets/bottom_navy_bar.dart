import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:mycustomdictionary/core/constants/strings/home_strings.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);
  @override
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavyBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(HomeStrings.bottomNavyBarItemHomeTitle),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.folder),
            title: Text(HomeStrings.bottomNavyBarItemFolderTitle),
            activeColor: Colors.greenAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(HomeStrings.bottomNavyBarItemProfileTitle),
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
