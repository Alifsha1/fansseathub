import 'dart:io';

import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/model/stadiumdetails.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddStadiumDetails extends StatefulWidget {
  const AddStadiumDetails({super.key});

  @override
  State<AddStadiumDetails> createState() => _AddStadiumDetails();
}

class _AddStadiumDetails extends State<AddStadiumDetails> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController stadiumnamecontroller = TextEditingController();
  final TextEditingController guestStandcontroller = TextEditingController();
  final TextEditingController guestStandpricecontroller =
      TextEditingController();
  final TextEditingController eastStanduppercontroller =
      TextEditingController();
  final TextEditingController eastStandupperpricecontroller =
      TextEditingController();
  final TextEditingController eastStandlowercontroller =
      TextEditingController();
  final TextEditingController eastStandlowerpricecontroller =
      TextEditingController();
  final TextEditingController northcontroller = TextEditingController();
  final TextEditingController northpricecontroller = TextEditingController();
  final TextEditingController acBoxseat15controller = TextEditingController();
  final TextEditingController acBoxseat15pricecontroller =
      TextEditingController();
  final TextEditingController acBox20controller = TextEditingController();
  final TextEditingController acBox20pricecontroller = TextEditingController();

  File? _selectedImage;
  late Box boxname2;
  @override
  void initState() {
    super.initState();
    boxname2 = Hive.box<StadiumDetails>('stadiumdetails');
  }

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
                  controller: stadiumnamecontroller,
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
                    controller: guestStandpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: eastStanduppercontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: eastStandupperpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: eastStandlowercontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: eastStandlowerpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: northcontroller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: northpricecontroller,
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
                    controller: acBoxseat15controller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: acBoxseat15pricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                AdminTextField(
                    hinttext: 'Stands',
                    controller: acBox20controller,
                    errormessage: 'stand name required'),
                Space,
                AdminTextField(
                    hinttext: 'ticket charge',
                    controller: acBox20pricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          addstadiumdetails();
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

  void addstadiumdetails() {
    if (_selectedImage == null) {
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
      String stadiumKey = DateTime.now().microsecondsSinceEpoch.toString();
      StadiumDetails stadiumDetails = StadiumDetails(
          stadiumKey: stadiumKey,
          imagePathstadium: _selectedImage!.path,
          stadiumname: stadiumnamecontroller.text,
          stands1: guestStandcontroller.text,
          ticketcharge1: guestStandpricecontroller.text,
          stands2: eastStanduppercontroller.text,
          ticketcharge2: eastStandupperpricecontroller.text,
          stands3: eastStandlowercontroller.text,
          ticketcharge3: eastStandlowerpricecontroller.text,
          stands4: northcontroller.text,
          ticketcharge4: northpricecontroller.text,
          standsac1: acBoxseat15controller.text,
          ticketchargeac1: acBoxseat15pricecontroller.text,
          standsac2: acBox20controller.text,
          ticketchargeac2: acBox20pricecontroller.text);
      boxname2.put(stadiumKey, stadiumDetails);
    
    }
  }
}
