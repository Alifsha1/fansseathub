import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/addUpcomingMatch.dart';
import 'package:fansseathub/screen/homeScreen.dart';
import 'package:fansseathub/screen/nxtGameAdding.dart';
import 'package:fansseathub/screen/userLoginScreen.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Heading(),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddNextGame(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '+Add next game',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddUpcomingGame(),
                    ),
                  );
                },
                child: Text(
                  '+Add upcoming matches',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {},
                child: InkWell(
                  onTap: () async {
                    await authService.signout();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const UserLoginScreen(),
                        ),
                        (route) => false);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: [
                    Text(
                      'Admin panel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              highlightsList(),
              SizedBox(
                height: 10,
              ),
              highlightsList(),
              SizedBox(
                height: 10,
              ),
              highlightsList(),
              SizedBox(
                height: 10,
              ),
              highlightsList(),
              SizedBox(
                height: 10,
              ),
              highlightsList(),
              SizedBox(
                height: 40,
              ),
              ButtonElevated(
                buttonText: '+Add new video',
              ),
            ],
          ),
        ),
      )),
    );
  }
}
