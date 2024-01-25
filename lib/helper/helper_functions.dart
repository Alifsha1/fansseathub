import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/hive/hive_Functions.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:fansseathub/screen/AdminSide/adminHomeScreen.dart';
import 'package:fansseathub/screen/Subpages/bottomBar.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:fansseathub/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userloggedInkey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailkey = "USEREMAILKEY";

  static Future<bool> saveUSerLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userloggedInkey, isUserLoggedIn);
  }

  static Future<bool> saveUSerNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUSerEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailkey, userEmail);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userloggedInkey);
  }

  static String adminloggedInkey = "ADMINLOGGEDINKEY";
  static String adminEmailkey = "ADMINEMAILKEY";

  static Future<bool> saveAdminLoggedInStatus(bool isAdminLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(adminloggedInkey, isAdminLoggedIn);
  }

  static Future<bool> saveAdminEmailSF(String adminEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(adminEmailkey, adminEmail);
  }

  static Future<bool?> getAdminLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(adminloggedInkey);
  }
  static Future<String?> getUserEmailFromSF()async{
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userEmailkey);
}
static Future<String?> getUserNameFromSF()async{
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getString(userNameKey);
}
}

Future<File?> pickImageFromGallery() async {
  final pickedimage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedimage != null) {
    return File(pickedimage.path);
  }
  return null;
}

submit({
  context,
  selectedImageteam1,
  selectedImageteam2,
  categorycontroller,
   datecontroller,
  gamenocontroller,
  matchdetailsbox,
  stadiumcontroller,
  team1controller,
  team2controller,
  timecontroller,
  typecontroller,
  selectedtype,
}) {
  
  if (selectedImageteam1 == null && selectedImageteam2 == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        'You Must select an image',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ));
    return;
  } else {
    String matchKey = DateTime.now().microsecondsSinceEpoch.toString();
    Repository.addmatchdetails(
      MatchDetails(
          matchKey: matchKey,
          team1: team1controller.text,
          team2: team2controller.text,
          imagePath1: selectedImageteam1,
          imagePath2: selectedImageteam2,
          time: timecontroller.text,
          date: datecontroller.text,
          category: categorycontroller.text,
          gameno: gamenocontroller.text,
          typeofgame: selectedtype,
          stadium: stadiumcontroller.text),
      matchKey,
    );
  }
}  

showDeleteConfirmationDialog(BuildContext context, matchKey) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete",
            style: TextStyle(color: Colors.black, fontSize: 15)),
        content: const Text("Are you sure you want to delete?",
            style: TextStyle(color: Colors.black, fontSize: 15)),
        actions: [
          TextButton(
            child: const Text("Cancel",
                style: TextStyle(color: Colors.black, fontSize: 15)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("delete",
                style: TextStyle(color: Colors.black, fontSize: 15)),
            onPressed: () {
              Repository.deleteData(matchKey);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

login(formkey, setStateCallback, _isLoading, authService, email, password,
    context, isAdminSigned) async {
  if (formkey.currentState!.validate()) {
    setStateCallback(() {
      _isLoading = true;
    });
    await authService
        .loginWithUserNameandPassword(email, password)
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot =
            await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);

        await HelperFunction.saveUSerLoggedInStatus(true);
        await HelperFunction.saveUSerEmailSF(email);
        await HelperFunction.saveUSerNameSF(snapshot.docs[0]['Name']);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                BottomBar(isUsersigned: true, idAdminsigned: isAdminSigned),
          ),
        );
      } else {
        showSnackbar(context, Colors.red, value);
        setStateCallback(() {
          _isLoading = false;
        });
      }
    });
  }
}

signup(formkey, setStateCallback, _isLoading, AuthService authService, fullName, email,
    password, context, _isUserSigned, _isAdminSigned) async {
  if (formkey.currentState!.validate()) {
    setStateCallback(() {
      _isLoading = true;
    });
    await authService
        .signupUserWithEmailandPassword(fullName, email, password, context)
        .then((value) async {
      if (value == true) {
        await HelperFunction.saveUSerLoggedInStatus(true);
        await HelperFunction.saveUSerEmailSF(email);
        await HelperFunction.saveUSerNameSF(fullName);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BottomBar(
                isUsersigned: _isUserSigned, idAdminsigned: _isAdminSigned),
          ),
        );
      } else {
        showSnackbar(context, Colors.red, value);
        setStateCallback(() {
          _isLoading = false;
        });
      }
    });
  }
}

showEditingDialog(context, MatchDetails match, formKey, mediaWidth, mediaHeight,
    setStateCallback) {
  return showDialog(
    context: context,
    builder: (context) {
      final TextEditingController team1Controller =
          TextEditingController(text: match.team1);
      final TextEditingController team2Controller =
          TextEditingController(text: match.team2);
      final TextEditingController timeController =
          TextEditingController(text: match.time.toString());
      final TextEditingController dateController =
          TextEditingController(text: match.date.toString());
      final TextEditingController categoryController =
          TextEditingController(text: match.category);
      final TextEditingController typeController =
          TextEditingController(text: match.typeofgame);
      final TextEditingController gamenoController =
          TextEditingController(text: match.gameno);
      final TextEditingController stadiumController =
          TextEditingController(text: match.stadium);
      String? selectedImageteam1;
      String? selectedImageteam2;
      String? matchKey = match.matchKey;
      return SingleChildScrollView(
        child: AlertDialog(
          content: Container(
            key: formKey,
            width: mediaWidth,
            height: mediaHeight,
            color: Colors.white,
            child: Column(
              children: [
                AdminTextField(
                    hinttext: 'Team1',
                    controller: team1Controller,
                    errormessage: 'Please enter Team 1'),
                AdminTextField(
                    hinttext: 'Team2',
                    controller: team2Controller,
                    errormessage: 'Please enter Team 2'),
                AdminTextField(
                    hinttext: 'Time',
                    controller: timeController,
                    errormessage: 'Please enter time'),
                AdminTextField(
                    hinttext: 'date',
                    controller: dateController,
                    errormessage: 'Please enter date'),
                AdminTextField(
                    hinttext: 'category',
                    controller: categoryController,
                    errormessage: 'Please enter the category'),
                AdminTextField(
                    hinttext: 'type',
                    controller: typeController,
                    errormessage: 'Please enter the type'),
                AdminTextField(
                    hinttext: 'gameno',
                    controller: gamenoController,
                    errormessage: 'Please enter gameno'),
                AdminTextField(
                    hinttext: 'stadium',
                    controller: stadiumController,
                    errormessage: 'Please enter stadium'),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          pickImageFromGallery().then((pickImage) {
                            if (pickImage != null) {
                              setStateCallback(() {
                                selectedImageteam1 = pickImage.path;
                              });
                            }
                          });
                        },
                        child: CircleAvatar(
                            radius: mediaHeight * .05,
                            // ignore: unnecessary_null_comparison
                            child: selectedImageteam1 != null
                                ? Image.file(File(selectedImageteam1))
                                : Image.file(File(match.imagePath1)))),

                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        pickImageFromGallery().then((pickImage) {
                          if (pickImage != null) {
                            setStateCallback(() {
                              match.imagePath2 = pickImage.path;
                            });
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: mediaHeight * .05,
                        backgroundImage: FileImage(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text('cancel')),
                    ElevatedButton(
                        onPressed: () {
                          Repository.updatematchdetails(
                              MatchDetails(
                                  matchKey: matchKey,
                                  team1: team1Controller.text,
                                  team2: team2Controller.text,
                                  imagePath1:
                                      selectedImageteam1 ?? match.imagePath1,
                                  imagePath2:
                                      selectedImageteam2 ?? match.imagePath2,
                                  time: match.time,
                                  date: match.date,
                                  category: categoryController.text,
                                  gameno: gamenoController.text,
                                  typeofgame: typeController.text,
                                  stadium: stadiumController.text),
                              matchKey);

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text('SAVE')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future adminlogin(
    context, adminEmailController, adminpasswordController) async {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      });
  await FirebaseFirestore.instance
      .collection("admin")
      .doc("adminLogin")
      .snapshots()
      .forEach((element) {
    if (element.data()?['adminEmail'] == adminEmailController &&
        element.data()?['adminPassword'] == adminpasswordController) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
          (route) => false);
      HelperFunction.saveAdminLoggedInStatus(true);
      HelperFunction.saveAdminEmailSF(adminEmailController);
    }
  }).catchError((e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('invalid'),
            content: Text(e.toString()),
          );
        });
  });
}
