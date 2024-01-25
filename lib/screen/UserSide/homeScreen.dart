
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/AdminSide/adminHomeScreen.dart';
import 'package:fansseathub/screen/UserSide/matchDetailsScreen.dart';
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
  String username = "";
  String email = "";
  // String? userProfilePic;
  AuthService authService = AuthService();
  // Stream<DocumentSnapshot>? userDataStream;
  @override
  void initState() {
    super.initState();
    gettingUserData();
   
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserNameFromSF().then((val) {
      setState(() {
        username = val!;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    //final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Heading(),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          widget.isUserSigned
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const AdminHomeScreen()));
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )))
        ],
        elevation: 0,
      ),
      drawer: drawerUserScreen(
          context, mediaWidth, authService, username, email),
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
                        builder: (context) => const MatchDetailsScreen(
                          type: 'cricket',
                          typeHeading: 'CRICKET',
                        ),
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
                          builder: (context) => const MatchDetailsScreen(
                            type: 'football',
                            typeHeading: 'FOOTBALL',
                          ),
                        ),
                      );
                    },
                    child: Catogory(displayImage: foot, sports: 'FOOTBALL')),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MatchDetailsScreen(
                            type: 'badminton',
                            typeHeading: 'BADMINTON',
                          ),
                        ),
                      );
                    },
                    child: Catogory(displayImage: bad, sports: 'BADMINTON')),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
