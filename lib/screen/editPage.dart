// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/dropdown.dart';
import 'package:fansseathub/hive/hive_Functions.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:hive/hive.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final MatchDetails match;
  final BuildContext context;
  final dynamic setStateCallback;
  //final Form formkey;
  // final String selectedtype;
  const EditPage({
    super.key,
    required this.match,
    required this.context,
    required this.setStateCallback,
    // required this.formkey,
    // required this.selectedtype
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

late Box<MatchDetails> matchdetailbox;
late List<MatchDetails> matchdetailList;

class _EditPageState extends State<EditPage> {
  final formkey = GlobalKey<FormState>();
  final formattime = DateFormat("HH:mm");
  final formatdate = DateFormat("yyyy-MM-dd");
  late Box<MatchDetails> matchdetailsbox;

  @override
  void initState() {
    super.initState();
    matchdetailbox = Hive.box<MatchDetails>('matchdetails');
    matchdetailList = matchdetailbox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController team1Controller =
        TextEditingController(text: widget.match.team1);
    final TextEditingController team2Controller =
        TextEditingController(text: widget.match.team2);
    final TextEditingController timeController =
        TextEditingController(text: widget.match.time.toString());
    final TextEditingController dateController =
        TextEditingController(text: widget.match.date.toString());
    final TextEditingController categoryController =
        TextEditingController(text: widget.match.category);
    final TextEditingController typeController =
        TextEditingController(text: widget.match.typeofgame);
    final TextEditingController gamenoController =
        TextEditingController(text: widget.match.gameno);
    final TextEditingController stadiumController =
        TextEditingController(text: widget.match.stadium);
    String? selectedImageteam1;
    String? selectedImageteam2;
    String? matchKey = widget.match.matchKey;
   

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
                      onTap: () {
                        pickImageFromGallery().then((pickImage) {
                          if (pickImage != null) {
                            setState(() {
                              widget.match.imagePath1 = pickImage.path;
                            });
                          }
                        });
                      },
                      child: ClipOval(
                        child: selectedImageteam1 != null
                            ? Image.file(
                                File(selectedImageteam1),
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              )
                            : Image.file(
                                File(widget.match.imagePath1),
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
                      onTap: () {
                        pickImageFromGallery().then((pickImage) {
                          if (pickImage != null) {
                            setState(() {
                              widget.match.imagePath2 = pickImage.path;
                            });
                          }
                        });
                      },
                      child: ClipOval(
                        child: selectedImageteam2 != null
                            ? Image.file(
                                File(selectedImageteam2),
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              )
                            : Image.file(
                                File(widget.match.imagePath2),
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
                  selectedtype: selectedType ?? '',
                  hintText: 'selecttype',
                  ontypeoption: (value) {
                    setState(() {
                      selectedType = value;
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
                        Repository.updatematchdetails(
                            MatchDetails(
                                matchKey: matchKey,
                                team1: team1Controller.text,
                                team2: team2Controller.text,
                                imagePath1: selectedImageteam1 ??
                                    widget.match.imagePath1,
                                imagePath2: selectedImageteam2 ??
                                    widget.match.imagePath2,
                                time: widget.match.time,
                                date: widget.match.date,
                                category: categoryController.text,
                                gameno: gamenoController.text,
                                typeofgame: typeController.text,
                                stadium: stadiumController.text),
                            matchKey);

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
