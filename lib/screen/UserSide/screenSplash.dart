// ignore_for_file: use_build_context_synchronously

import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/AdminSide/adminHomeScreen.dart';
import 'package:fansseathub/screen/Subpages/bottomBar.dart';

import 'package:fansseathub/screen/UserSide/userLoginScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isUserSigned = false;
  bool _isAdminSigned = false;

  @override
  initState() {
    super.initState();
    getUserLoggedInStatus();
    getAdminLoggedInStatus();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: mediaHeight * .15,
              ),
              const Heading(),
              Image.asset(
                  'assets/retro-black-and-white-style-illustration-of-a-cricket-player-or-batsman-with-bat-batting-viewed-from-front-on-isolated-background-2JFKJ1J.jpg'),
              const Text(
                'BOOK IT',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Miltonian_Tattoo"),
              ),
              const Text(
                'NOW!',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Miltonian_Tattoo"),
              ),
              // const SizedBox(
              //   height: 40,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    if (_isUserSigned) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomBar(
                isUsersigned: _isUserSigned, idAdminsigned: _isAdminSigned),
          ),
          (route) => false);
    } else if (_isAdminSigned) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const AdminHomeScreen(),
          ),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const UserLoginScreen(),
          ),
          (route) => false);
    }
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isUserSigned = value;
        });
      }
    });
  }

  getAdminLoggedInStatus() async {
    await HelperFunction.getAdminLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isAdminSigned = value;
        });
      }
    });
  }
}
