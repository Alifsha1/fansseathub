import 'dart:io';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:hive/hive.dart';
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

  late Box<MatchDetails> matchdetailsbox;

  @override
  void initState() {
    super.initState();
    matchdetailsbox = Hive.box('matchdetails');
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
                      print(value);
                    });
                  },
                  // ontypeoption: ,

                  onTap1: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      _selectedImageteam1 = pickimage;
                    });
                  },
                  onTap2: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      _selectedImageteam2 = pickimage;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          submit(
                              context: context,
                              selectedImageteam1: _selectedImageteam1!.path,
                              selectedImageteam2: _selectedImageteam2!.path,
                              categorycontroller: categorycontroller,
                              datecontroller: datecontroller,
                              gamenocontroller: gamenocontroller,
                              matchdetailsbox: matchdetailsbox,
                              stadiumcontroller: stadiumcontroller,
                              team1controller: team1controller,
                              team2controller: team2controller,
                              timecontroller: timecontroller,
                              typecontroller: typecontroller,
                              selectedtype: selectedType);
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
}
