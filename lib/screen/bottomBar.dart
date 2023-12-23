import 'package:fansseathub/screen/homeScreen.dart';
import 'package:fansseathub/screen/profileScreen.dart';
import 'package:fansseathub/screen/searchScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  bool isUsersigned;
  bool idAdminsigned;
  BottomBar({
    super.key,
    required this.isUsersigned,
    required this.idAdminsigned,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  List<dynamic> tabs = [];

  @override
  void initState() {
    tabs = [
      HomeScreen(
        isUserSigned: widget.isUsersigned,
        idAdminSigned: widget.idAdminsigned,
      ),
      const SearchScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: tabs[index],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  //color: Colors.black,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  //color: Colors.black,
                ),
                label: 'search'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  // color: Colors.black,
                ),
                label: 'profile'),
          ],
        ),
      ),
    );
  }
}
