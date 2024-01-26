import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fansseathub/helper/widgets/addingField.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddNextGame extends StatefulWidget {
  // final String selectedtype;
  const AddNextGame({
    super.key,
    // required this.selectedtype
  });

  @override
  State<AddNextGame> createState() => _AddFirstGameState();
}

class _AddFirstGameState extends State<AddNextGame> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController team1controller = TextEditingController();
  final TextEditingController team2controller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController categorycontroller = TextEditingController();
  final TextEditingController typecontroller = TextEditingController();
  final TextEditingController gamenocontroller = TextEditingController();
  final TextEditingController stadiumcontroller = TextEditingController();
  File? _selectedImageteam1;
  File? _selectedImageteam2;
  String? selectedType;
  String? team1ImageUrl;
  String? team2ImageUrl;

  //late Box<MatchDetails> matchdetailsbox;

  @override
  void initState() {
    super.initState();
    // matchdetailsbox = Hive.box('matchdetails');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const HeadingWhite()
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      'Add next game details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GameAddingField(
                  team1Controller: team1controller,
                  team2Controller: team2controller,
                  dateController: datecontroller,
                  timeController: timecontroller,
                  categoryController: categorycontroller,
                  gamenoController: gamenocontroller,
                  typeController: typecontroller,
                  stadiumController: stadiumcontroller,
                  imageSelectedteam1: _selectedImageteam1,
                  imageSelectedteam2: _selectedImageteam2,
                  selectedtype: selectedType ?? '',
                  ontypeoption: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  // ontypeoption: ,

                  onTap1: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      _selectedImageteam1 = pickimage;
                    });
                    String fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDireImage =
                        referenceRoot.child('team1image');
                    Reference referenceImageToUpload =
                        referenceDireImage.child(fileName);
                    try {
                      await referenceImageToUpload
                          .putFile(File(pickimage!.path));
                      team1ImageUrl =
                          await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //some error
                    }
                  },
                  onTap2: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      _selectedImageteam2 = pickimage;
                    });
                    String fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDireImage =
                        referenceRoot.child('team2image');
                    Reference referenceImageToUpload =
                        referenceDireImage.child(fileName);
                    try {
                      await referenceImageToUpload
                          .putFile(File(pickimage!.path));
                      team2ImageUrl =
                          await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //some error
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          submittofirebase();
                          dataClear();

                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        '     Submit    ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  void dataClear() {
    team1controller.clear();
    team2controller.clear();
    _selectedImageteam1 = null;
    _selectedImageteam2 = null;
    timecontroller.clear();
    datecontroller.clear();
    categorycontroller.clear();
    gamenocontroller.clear();
    typecontroller.clear();
    stadiumcontroller.clear();
  }

  submittofirebase() async {
    if (_selectedImageteam1 == null && _selectedImageteam2 == null) {
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
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("matches").doc();

      String team1 = team1controller.text;
      String team2 = team2controller.text;
      String category = categorycontroller.text;
      String date = datecontroller.text;
      String gameno = gamenocontroller.text;
      String stadium = stadiumcontroller.text;
      String time = timecontroller.text;
      documentReference.set({
        "team1": team1,
        "team2": team2,
        "selectedImageteam1": team1ImageUrl,
        "selectedImageteam2": team2ImageUrl,
        "categorycontroller": category,
        "datecontroller": date,
        "gamenocontroller": gameno,
        "stadiumcontroller": stadium,
        "timecontroller": time,
        "selectedtype": selectedType
      });
    }
  }
}
