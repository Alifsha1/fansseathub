import 'dart:io';

import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/hive/hive_Functions.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:fansseathub/screen/addUpcomingMatch.dart';
import 'package:fansseathub/screen/homeScreen.dart';
import 'package:fansseathub/screen/nxtGameAdding.dart';
import 'package:fansseathub/screen/userLoginScreen.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

final _formKey = GlobalKey<FormState>();
late Box<MatchDetails> matchdetailbox;
late List<MatchDetails> matchdetailList;

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool _isUserSigned = false;
  bool _isAdminSigned = false;
  @override
  void initState() {
    matchdetailbox = Hive.box<MatchDetails>('matchdetails');
    matchdetailList = matchdetailbox.values.toList();
    super.initState();
  }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Heading(),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                              isUserSigned: _isUserSigned,
                              idAdminSigned: _isAdminSigned),
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
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddUpcomingGame(),
                      ),
                    );
                  },
                  child: const Text(
                    '+Add details',
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
                      await authService.showSignOutConfirmationDialog(context);
                      
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
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  'Admin panel',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: mediaHeight - 200, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: matchdetailList.length,
                  itemBuilder: (context, index) {
                    final match = matchdetailList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: mediaHeight * 0.1,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 204, 197, 197),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                            Expanded(child: Text(match.team1)),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('VS'),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text(match.team2)),
                            SizedBox(
                              width: mediaWidth * .2,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      int id = 0;
                                      final TextEditingController
                                          team1Controller =
                                          TextEditingController(
                                              text: match.team1);
                                      final TextEditingController
                                          team2Controller =
                                          TextEditingController(
                                              text: match.team2);
                                      final TextEditingController
                                          timeController =
                                          TextEditingController(
                                              text: match.time);
                                      final TextEditingController
                                          dateController =
                                          TextEditingController(
                                              text: match.date);
                                      final TextEditingController
                                          categoryController =
                                          TextEditingController(
                                              text: match.category);
                                      final TextEditingController
                                          typeController =
                                          TextEditingController(
                                              text: match.typeofgame);
                                      final TextEditingController
                                          gamenoController =
                                          TextEditingController(
                                              text: match.gameno);
                                      final TextEditingController
                                          stadiumController =
                                          TextEditingController(
                                              text: match.stadium);
                                      String? _selectedImageteam1;
                                      String? _selectedImageteam2;
                                      String? matchKey = match.matchKey;
                                      return SingleChildScrollView(
                                        child: AlertDialog(
                                          content: Container(
                                            key: _formKey,
                                            width: mediaWidth,
                                            height: mediaHeight,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                AdminTextField(
                                                    hinttext: 'Team1',
                                                    controller: team1Controller,
                                                    errormessage:
                                                        'Please enter Team 1'),
                                                AdminTextField(
                                                    hinttext: 'Team2',
                                                    controller: team2Controller,
                                                    errormessage:
                                                        'Please enter Team 2'),
                                                AdminTextField(
                                                    hinttext: 'Time',
                                                    controller: timeController,
                                                    errormessage:
                                                        'Please enter time'),
                                                AdminTextField(
                                                    hinttext: 'date',
                                                    controller: dateController,
                                                    errormessage:
                                                        'Please enter date'),
                                                AdminTextField(
                                                    hinttext: 'category',
                                                    controller:
                                                        categoryController,
                                                    errormessage:
                                                        'Please enter the category'),
                                                AdminTextField(
                                                    hinttext: 'type',
                                                    controller: typeController,
                                                    errormessage:
                                                        'Please enter the type'),
                                                AdminTextField(
                                                    hinttext: 'gameno',
                                                    controller:
                                                        gamenoController,
                                                    errormessage:
                                                        'Please enter gameno'),
                                                AdminTextField(
                                                    hinttext: 'stadium',
                                                    controller:
                                                        stadiumController,
                                                    errormessage:
                                                        'Please enter stadium'),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          pickImageFromGallery()
                                                              .then(
                                                                  (pickImage) {
                                                            if (pickImage !=
                                                                null) {
                                                              setState(() {
                                                                _selectedImageteam1 =
                                                                    pickImage
                                                                        .path;
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: CircleAvatar(
                                                            radius:
                                                                mediaHeight *
                                                                    .05,
                                                            child: _selectedImageteam1 !=
                                                                    null
                                                                ? Image.file(File(
                                                                    _selectedImageteam1))
                                                                : Image.file(
                                                                    File(match
                                                                        .imagePath1)))
                                                        // backgroundImage:
                                                        //     FileImage(
                                                        //   File(
                                                        //     match.imagePath1,
                                                        //   ),
                                                        // ),
                                                        ),

                                                    Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickImageFromGallery()
                                                            .then((pickImage) {
                                                          if (pickImage !=
                                                              null) {
                                                            setState(() {
                                                              match.imagePath2 =
                                                                  pickImage
                                                                      .path;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                        radius:
                                                            mediaHeight * .05,
                                                        backgroundImage:
                                                            FileImage(
                                                          File(
                                                            match.imagePath2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.black,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50))),
                                                        child: Text('cancel')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          // if (_formKey.currentState !=
                                                          //         null &&
                                                          //     _formKey
                                                          //         .currentState!
                                                          //         .validate()) {
                                                          print('updating');

                                                          Repository.updatematchdetails(
                                                              MatchDetails(
                                                                  matchKey:
                                                                      matchKey,
                                                                  team1: team1Controller
                                                                      .text,
                                                                  team2:
                                                                      team2Controller
                                                                          .text,
                                                                  imagePath1:
                                                                      _selectedImageteam1 ??
                                                                          match
                                                                              .imagePath1,
                                                                  imagePath2:
                                                                      _selectedImageteam2 ??
                                                                          match
                                                                              .imagePath2,
                                                                  time: timeController
                                                                      .text,
                                                                  date: dateController
                                                                      .text,
                                                                  category:
                                                                      categoryController
                                                                          .text,
                                                                  gameno:
                                                                      gamenoController
                                                                          .text,
                                                                  typeofgame:
                                                                      typeController
                                                                          .text,
                                                                  stadium:
                                                                      stadiumController
                                                                          .text),
                                                              matchKey);
                                                          //}
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.black,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50))),
                                                        child:
                                                            const Text('SAVE')),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  Repository.deleteData(match.matchKey);
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ButtonElevated(
                buttonText: '+Add new video',
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<File?> pickImageFromGallery() async {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      return File(pickedimage.path);
    }
    return null;
  }
}
