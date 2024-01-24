import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/helper_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String? userId;
  final String? image;
  final String? fullName;
  final String? email;
  //final Stream<DocumentSnapshot<Object?>>? stream;
  const EditProfile({
    super.key,
    this.userId,
    this.image,
    this.fullName,
    this.email,
    //required this.stream
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // late Stream<QuerySnapshot> _stream;
  File? profileImage;
  String? profileImageUrl;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? trimmedName;
  bool isLoading = false;
  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    nameController.text = widget.fullName ?? '';
    emailController.text = widget.email ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController nameController =
    //     TextEditingController(text: items['user']);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'profile',
          style: TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      File? pickimage = await pickImageFromGallery();
                      setState(() {
                        profileImage = pickimage;
                      });
                      String fileName =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDireImage =
                          referenceRoot.child('profilepic');
                      Reference referenceImageToUpload =
                          referenceDireImage.child(fileName);
                      try {
                        await referenceImageToUpload
                            .putFile(File(pickimage!.path));
                        profileImageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        submitprofilr(widget.userId!);
                      } catch (error) {
                        //some error
                      }
                    },
                    child: profileImage != null
                        ? ClipOval(
                            child: Image.file(
                              profileImage!,
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
                            ),
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 200,
                            color: Colors.grey[700],
                          ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title(
                    //   color: Colors.black,
                    //   child: Text(
                    //     'Full Name',
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        trimmedName = value!.trim();
                        debugPrint(
                            'value name on validation: ${trimmedName ?? 'name'}');
                        if (trimmedName!.isEmpty) {
                          const SnackBar(content: Text('Please enter a name'));
                          return '';
                        } else {
                          return null;
                        }
                      },
                    ),
                    // Title(
                    //   color: Colors.black,
                    //   child: Text(
                    //     'email Address',
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                submitprofilr(widget.userId!);
                                Navigator.of(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: const Text(
                                '       save        ',
                                style: TextStyle(),
                              )),
                        ),
                      ],
                    )
                  ],
                )),
              )
            ],
          ),
        )),
      ),
    );
  }

  submitprofilr(String id) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("user").doc(id);
    String name = nameController.text;
    String email = emailController.text;
    await documentReference
        .update({"Name": name, "email": email, "profilepic": profileImageUrl});
  }
}
