import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/editPage.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

final _formKey = GlobalKey<FormState>();

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final bool _isUserSigned = false;
  final bool _isAdminSigned = false;
  late Stream<QuerySnapshot> _stream;
  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('matches').snapshots();
  }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Heading(),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      drawer: drawerAdminScreen(
          context, mediaWidth, _isAdminSigned, _isUserSigned, authService),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  'Admin panel',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: mediaHeight - 200, // Adjust the height as needed
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Some Error occured${snapshot.error}"),
                        );
                      }
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data;
                        List<QueryDocumentSnapshot> document =
                            querySnapshot.docs;
                        List<Map> items =
                            document.map((e) => e.data() as Map).toList();

                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            Map thisItems = items[index];
                            String id = snapshot.data.docs[index].id;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: mediaHeight * 0.1,
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 204, 197, 197),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${thisItems['team1']}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'VS',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${thisItems['team2']}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(
                                      width: mediaWidth * .1,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditPage(
                                                thisItems: thisItems,
                                                setStateCallback: setState,
                                                id: id,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          DocumentReference documentReference =
                                              FirebaseFirestore.instance
                                                  .collection("matches")
                                                  .doc(id);
                                          documentReference
                                              .delete()
                                              .whenComplete(() {
                                          });
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ))
            ],
          ),
        ),
      )),
    );
  }

  deleteData() {

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("").doc();
    documentReference.delete().whenComplete(() {
     
    });
  }
}
