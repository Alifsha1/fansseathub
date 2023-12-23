import 'dart:io';

import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StadiumDetails extends StatefulWidget {
  const StadiumDetails({super.key});

  @override
  State<StadiumDetails> createState() => _StadiumDetailsState();
}

class _StadiumDetailsState extends State<StadiumDetails> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController guestStandcontroller = TextEditingController();
  final TextEditingController eastStanduppercontroller =
      TextEditingController();
  final TextEditingController eastStandlowercontroller =
      TextEditingController();
  final TextEditingController northcontroller = TextEditingController();
  final TextEditingController acBoxseat15controller = TextEditingController();
  final TextEditingController acBox20controller = TextEditingController();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    // final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    final Space = SizedBox(
      height: mediaHeight * .01,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Heading(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const Row(
                  children: [
                    AdminSideHeadingsBlack(headings: 'Details'),
                  ],
                ),
                SizedBox(
                  height: mediaHeight * .05,
                ),
                GestureDetector(
                  onTap: () async {
                    File? pickimage = await pickImageFromGallery();
                    setState(() {
                      _selectedImage = pickimage;
                    });
                  },
                  child: _selectedImage != null
                      ? CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: mediaHeight,
                            height: mediaHeight * .28,
                          ),
                        )
                      : const Icon(
                          Icons.image_outlined,
                          color: Colors.black,
                          size: 70,
                        ),
                ),
                SizedBox(
                  height: mediaHeight * .1,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(
                  height: mediaHeight * .01,
                ),
                const Row(
                  children: [
                    AdminSideHeadingsBlack(headings: 'Stands'),
                    AdminSideHeadingsBlack(headings: '&'),
                    AdminSideHeadingsBlack(headings: 'Tickets Charges')
                  ],
                ),
                Space,
                AdminTextField(
                  hinttext: 'Stadium name',
                  controller: guestStandcontroller,
                  errormessage: 'name required',
                ),
                Space,
                AdminTextField(
                  hinttext: 'Stands',
                  controller: guestStandcontroller,
                  errormessage: 'stand name required',
                ),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: guestStandcontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: guestStandcontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: guestStandcontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: guestStandcontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: guestStandcontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: guestStandcontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: guestStandcontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                const Row(
                  children: [
                    AdminSideHeadingsBlack(headings: 'Air Condition Boxes'),
                  ],
                ),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: guestStandcontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: guestStandcontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: guestStandcontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: guestStandcontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        '     Submit    ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
