// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/dropdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final Map<dynamic, dynamic> thisItems;
  final String id;
  // final MatchDetails match;
  // final BuildContext context;
  final dynamic setStateCallback;
  //final Form formkey;
  // final String selectedtype;
  const EditPage({
    super.key,
    // required this.match,
    // required this.context,
    required this.setStateCallback,
    required this.thisItems,
    required this.id,
    // required this.formkey,
    // required this.selectedtype
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

// late Box<MatchDetails> matchdetailbox;
// late List<MatchDetails> matchdetailList;

class _EditPageState extends State<EditPage> {
  final formkey = GlobalKey<FormState>();
  final formattime = DateFormat("HH:mm");
  final formatdate = DateFormat("yyyy-MM-dd");
  late String _initialSelectedType;
  //late Box<MatchDetails> matchdetailsbox;

  @override
  void initState() {
    super.initState();
    _initialSelectedType = widget.thisItems['selectedtype'];
    // matchdetailbox = Hive.box<MatchDetails>('matchdetails');
    // matchdetailList = matchdetailbox.values.toList();
    print('${widget.thisItems['selectedImageteam1']}');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController team1Controller =
        TextEditingController(text: widget.thisItems['team1']);
    final TextEditingController team2Controller =
        TextEditingController(text: widget.thisItems['team2']);
    final TextEditingController timeController =
        TextEditingController(text: widget.thisItems['timecontroller']);
    final TextEditingController dateController =
        TextEditingController(text: widget.thisItems['datecontroller']);
    final TextEditingController categoryController =
        TextEditingController(text: widget.thisItems['categorycontroller']);
    final TextEditingController typeController =
        TextEditingController(text: widget.thisItems['selectedtype']);
    final TextEditingController gamenoController =
        TextEditingController(text: widget.thisItems['gamenocontroller']);
    final TextEditingController stadiumController =
        TextEditingController(text: widget.thisItems['stadiumcontroller']);
    File? selectedImageteam1;
    File? selectedImageteam2;
    String? team1ImageUrl;
    String? team2ImageUrl;
    //String? imageUrl;

    // String? matchKey = widget.match.matchKey;

    String? selectedType;
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
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Enter Team'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AdminTextField(
                  errormessage: "team name cannot be empty",
                  controller: team1Controller,
                  hinttext: 'Enter Team',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'flag team 1'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        File? pickImage = await pickImageFromGallery();
                        //then((pickImage) {
                        if (pickImage != null) {
                          setState(() {
                            selectedImageteam1 = pickImage;
                          });
                        }
                        // });
                        // String fileName =
                        //     DateTime.now().microsecondsSinceEpoch.toString();
                        //get reference to storage root
                        //we create the image folder first and insider folder we upload the image
                        // Reference referenceRoot =
                        //     FirebaseStorage.instance.ref();
                        // Reference referenceDireImage =
                        //     referenceRoot.child('team1image');
                        // //we have create reference for the image to be stored
                        // Reference referenceImageToUpload =
                        //     referenceDireImage.child(fileName);
                        // //for error handled and/or success
                        print(
                            'firebase image: ${widget.thisItems['selectedImageteam1']}');
                        print('selected image: $selectedImageteam1');
                        Reference referenceImageToUpload = FirebaseStorage
                            .instance
                            .refFromURL(widget.thisItems['selectedImageteam1']);
                        try {
                          await referenceImageToUpload
                              .putFile(File(pickImage!.path));
                          team1ImageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          //some error
                          print('error uploading $error');
                        }

                        print('team1 image: $team1ImageUrl');
                      },
                      child: ClipOval(
                        child: selectedImageteam1 != null
                            ? Image.file(
                                File(selectedImageteam1.path),
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              )
                            : Image.network(
                                widget.thisItems['selectedImageteam1'],
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: AdminSideHeadings(headings: 'VS'),
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Enter Team'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AdminTextField(
                  errormessage: "team name cannot be empty",
                  controller: team2Controller,
                  hinttext: 'Enter Team',
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'flag team 1'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        File? pickImage = await pickImageFromGallery();
                        //.then((pickImage) {
                        if (pickImage != null) {
                          setState(() {
                            selectedImageteam2 = pickImage;
                          });
                        }
                        //   });
                        // String fileName =
                        //     DateTime.now().microsecondsSinceEpoch.toString();
                        //get reference to storage root
                        //we create the image folder first and insider folder we upload the image
                        // Reference referenceRoot =
                        //     FirebaseStorage.instance.ref();
                        // Reference referenceDireImage =
                        //     referenceRoot.child('team2image');
                        // //we have create reference for the image to be stored
                        // Reference referenceImageToUpload =
                        //     referenceDireImage.child(fileName);
                        // // Reference referenceImageToUpload =
                        // //     FirebaseStorage.instance.refFromURL( widget.thisItems['selectedImageteam2']);
                        //for error handled and/or success
                        Reference referenceImageToUpload = FirebaseStorage
                            .instance
                            .refFromURL(widget.thisItems['selectedImageteam2']);

                        try {
                          await referenceImageToUpload
                              .putFile(File(pickImage!.path));
                          team1ImageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          //some error
                        }
                      },
                      child: ClipOval(
                        child: selectedImageteam2 != null
                            ? Image.file(
                                File(selectedImageteam2.path),
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              )
                            : Image.network(
                                widget.thisItems['selectedImageteam2'],
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Time'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DateTimeField(
                  controller: timeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'time',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  format: formattime,
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Category'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AdminTextField(
                  errormessage: "category name cannot be empty",
                  hinttext: 'Enter category',
                  controller: categoryController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Type'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownFormField(
                  selectedtype: selectedType ?? _initialSelectedType,
                  hintText: 'selecttype',
                  ontypeoption: (value) {
                    setState(() {
                      selectedType = value;
                      _initialSelectedType = value;
                      print(value);
                    });
                  },
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Date'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DateTimeField(
                  controller: dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: 'date',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  format: formatdate,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Game no'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AdminTextField(
                  hinttext: 'Enter no',
                  errormessage: "gameno name cannot be empty",
                  controller: gamenoController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    AdminSideHeadings(headings: 'Stadium'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AdminTextField(
                  errormessage: "stadium name cannot be empty",
                  hinttext: 'Enter stadium',
                  controller: stadiumController,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        DocumentReference documentReference = FirebaseFirestore
                            .instance
                            .collection("matches")
                            .doc(widget.id);

                        String team1 = team1Controller.text;
                        String team2 = team2Controller.text;
                        String category = categoryController.text;
                        String date = dateController.text;
                        String gameno = gamenoController.text;
                        String stadium = stadiumController.text;
                        String time = timeController.text;
                        String type = typeController.text;

                        print("on updating team 1 $team1ImageUrl");
                        documentReference.update({
                          "team1": team1,
                          "team2": team2,
                          "selectedImageteam1": team1ImageUrl,
                          "selectedImageteam2": team2ImageUrl,
                          "categorycontroller": category,
                          "datecontroller": date,
                          "gamenocontroller": gameno,
                          // "matchdetailsbox": matchdetailsbox,
                          "stadiumcontroller": stadium,
                          "timecontroller": time,
                          "typecontroller": type,
                          "selectedtype": _initialSelectedType,
                        });
                        Navigator.pop(context);
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
}
