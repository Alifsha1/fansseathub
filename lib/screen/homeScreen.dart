import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/adminHomeScreen.dart';
import 'package:fansseathub/screen/matchDetailsScreen.dart';
import 'package:fansseathub/screen/userLoginScreen.dart';
import 'package:fansseathub/sections/assets.dart';
import 'package:fansseathub/sections/catogory.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isUserSigned;
  final bool idAdminSigned;
  const HomeScreen({
    super.key,
    required this.isUserSigned,
    required this.idAdminSigned,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    print('${widget.isUserSigned},${widget.idAdminSigned}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Heading(),
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 45,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'search',
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 64, 63, 63),
                ),
              ),
            ),
          ),
        ),
        actions: [
          widget.idAdminSigned
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AdminHomeScreen()));
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )))
        ],
        elevation: 0,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Favorites',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {},
                child: InkWell(
                  onTap: () async {
                    await authService.showSignOutConfirmationDialog(context);
                    // ignore: use_build_context_synchronously
                  
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
          padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const MatchDetailsScreen(type: 'cricket',typeHeading: 'CRICKET',),
                      ),
                    );
                  },
                  child: Catogory(
                    displayImage: crik,
                    sports: 'CRICKET',
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const MatchDetailsScreen(type: 'football',typeHeading: 'FOOTBALL',),
                        ),
                      );
                    },
                    child: Catogory(displayImage: foot, sports: 'FOOTBALL')),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const MatchDetailsScreen(type: 'badminton',typeHeading: 'BADMINTON',),
                        ),
                      );
                    },
                    child: Catogory(displayImage: bad, sports: 'BADMINTON')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}