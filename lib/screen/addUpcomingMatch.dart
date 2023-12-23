import 'dart:io';
import 'package:fansseathub/helper/widgets/addingField.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddUpcomingGame extends StatefulWidget {
  const AddUpcomingGame({super.key});

  @override
  State<AddUpcomingGame> createState() => _AddFirstGameState();
}

class _AddFirstGameState extends State<AddUpcomingGame> {
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
                      'Add upcoming game details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
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
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        submit();
                        //Navigator.pop(context);
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
      saveDetails();
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

  void saveDetails() {}
}
