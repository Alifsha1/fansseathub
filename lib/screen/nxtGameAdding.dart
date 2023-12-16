import 'dart:io';
import 'package:fansseathub/hive/hive_Functions.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fansseathub/helper/widgets/addingField.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddNextGame extends StatefulWidget {
  const AddNextGame({super.key});

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
  late Box<MatchDetails> matchdetailsbox;

  @override
  void initState() {
    // TODO: implement initState
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
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    HeadingWhite()
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
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
                SizedBox(
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
                  onTap1: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      _selectedImageteam1 = pickimage;
                      // _selectedImageteam2 = pickimage;
                    });
                  },
                  onTap2: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      // _selectedImageteam1 = pickimage;
                      _selectedImageteam2 = pickimage;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          submit();
                          dataClear();
                           Navigator.pop(context);
                          print("matchdetailsaddding");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text(
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

  submit() {
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
      String matchKey = DateTime.now().microsecondsSinceEpoch.toString();
      Repository.addmatchdetails(
        MatchDetails(
            matchKey: matchKey,
            team1: team1controller.text,
            team2: team2controller.text,
            imagePath1: _selectedImageteam1!.path,
            imagePath2: _selectedImageteam2!.path,
            time: timecontroller.text,
            date: datecontroller.text,
            category: categorycontroller.text,
            gameno: gamenocontroller.text,
            typeofgame: typecontroller.text,
            stadium: stadiumcontroller.text),
        matchKey,
      );
      dataClear();
      print("savedateils");
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
