import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
  String? stadiumImageUrl;
  File? _selectedImage;
  // late Box boxname2;
  @override
  void initState() {
    super.initState();
    // boxname2 = Hive.box<StadiumDetails>('stadiumdetails');
  }

  @override
  Widget build(BuildContext context) {
    // final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    final Space = SizedBox(
      height: mediaHeight * .02,
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
                    String fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    //get reference to storage root
                    //we create the image folder first and insider folder we upload the image
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDireImage =
                        referenceRoot.child('stadiumimage');
                    //we have create reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDireImage.child(fileName);
                    //for error handled and/or success
                    try {
                      await referenceImageToUpload
                          .putFile(File(pickimage!.path));
                      stadiumImageUrl =
                          await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //some error
                    }
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
                StadiumTextField(
                  label: Text('Stadium name'),
                  controller: stadiumnamecontroller,
                  errormessage: 'name required',
                ),
                Space,
                StadiumTextField(
                  label: Text('Stands'),
                  controller: guestStandcontroller,
                  errormessage: 'stand name required',
                ),
                Space,
                StadiumTextField(
                    label: Text('ticket charge'),
                    controller: guestStandpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                StadiumTextField(
                    label: Text('Stands'),
                    controller: eastStanduppercontroller,
                    errormessage: 'stand name required'),
                Space,
                StadiumTextField(
                    label: Text('ticket charge'),
                    controller: eastStandupperpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                StadiumTextField(
                    label: Text('Stands'),
                    controller: eastStandlowercontroller,
                    errormessage: 'stand name required'),
                Space,
                StadiumTextField(
                    label: Text('ticket charge'),
                    controller: eastStandlowerpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                StadiumTextField(
                    label: Text('Stands'),
                    controller: northcontroller,
                    errormessage: 'stand name required'),
                Space,
                StadiumTextField(
                    label: Text('ticket charge'),
                    controller: northpricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                const Row(
                  children: [
                    AdminSideHeadingsBlack(headings: 'Air Condition Boxes'),
                  ],
                ),
                Space,
                StadiumTextField(
                    label: Text('Stands'),
                    controller: acBoxseat15controller,
                    errormessage: 'stand name required'),
                Space,
                StadiumTextField(
                    label: Text('ticket charge'),
                    controller: acBoxseat15pricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                StadiumTextField(
                    label: Text('Stands'),
                    controller: acBox20controller,
                    errormessage: 'stand name required'),
                Space,
                StadiumTextField(
                    label: Text('ticket charge'),
                    controller: acBox20pricecontroller,
                    errormessage: 'ticket charge  required'),
                Space,
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          addstadiumdetailstofirebase();
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
    } else {}
  }

  addstadiumdetailstofirebase() async {
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
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("stadiums").doc();

      String stadiumname = stadiumnamecontroller.text;
      String stands1 = guestStandcontroller.text;
      String ticketcharge1 = guestStandpricecontroller.text;
      String stands2 = eastStanduppercontroller.text;
      String ticketcharge2 = eastStandupperpricecontroller.text;
      String stands3 = eastStandlowercontroller.text;
      String ticketcharge3 = eastStandlowerpricecontroller.text;
      String stands4 = northcontroller.text;
      String ticketcharge4 = northpricecontroller.text;
      String standsac1 = acBoxseat15controller.text;
      String ticketchargeac1 = acBoxseat15pricecontroller.text;
      String standsac2 = acBox20controller.text;
      String ticketchargeac2 = acBox20pricecontroller.text;
      documentReference.set({
        "imagePathstadium": stadiumImageUrl,
        "stadiumname": stadiumname,
        "stands1": stands1,
        "ticketcharge1": ticketcharge1,
        "stands2": stands2,
        "ticketcharge2": ticketcharge2,
        "stands3": stands3,
        "ticketcharge3": ticketcharge3,
        "stands4": stands4,
        "ticketcharge4": ticketcharge4,
        "standsac1": standsac1,
        "ticketchargeac1": ticketchargeac1,
        "standsac2": standsac2,
        "ticketchargeac2": ticketchargeac2,
      });
    }
  }
}
