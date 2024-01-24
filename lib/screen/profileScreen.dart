// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/screen/editProfile.dart';
import 'package:fansseathub/sections/assets.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:fansseathub/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  String username;
  String email;
  ProfileScreen({super.key, required this.email, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String email = "";
  String? userProfilePic;
  AuthService authService = AuthService();
  Stream<DocumentSnapshot>? userDataStream;

  @override
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser!.uid);
    //gettingUserData();
    gettingUserData();
    userDataStream = DatabaseService()
        .getUserDetails(FirebaseAuth.instance.currentUser!.uid);
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
    // getting the list of snapshot in our stream

    // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
    //     .getUserGroups()
    //     .then((snapshot) {
    //   setState(() {
    //     groups = snapshot;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: userDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userDataSnapshot =
                      snapshot.data?.data() as Map<String, dynamic>;
                  username = (userDataSnapshot['Name'] as String);
                  email = userDataSnapshot['email'];
                  userProfilePic = userDataSnapshot['profilepic'] ?? "https://firebasestorage.googleapis.com/v0/b/fansseathub.appspot.com/o/profilepic%2F1706017404040831?alt=media&token=3d350d73-9888-4426-adf6-537e269fe98a"
;
                  print('aaa- $userProfilePic');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.005),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 2.5),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 2,
                                color: Color(0x1A000000),
                              )
                            ],
                          ),
                          child:  ClipOval(
                    child: 
                      userProfilePic!.isNotEmpty ?
                    Image.network(
                      // userDataSnapshot['profilepic'],
                           userProfilePic!,
                      fit: BoxFit.cover,
                      width: 140,
                      height: 140,
                    ) : Image.asset(crik)
                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Full Name",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            // widget.username,
                            username,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "email ",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            //  widget.email,
                            email,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          email: widget.email,
                                          fullName: widget.username,
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          //stream: userDataStream,
                                        )),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Text(
                              'Edit',
                              style: TextStyle(),
                            )),
                      )
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
