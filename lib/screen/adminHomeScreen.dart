import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:fansseathub/screen/editPage.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

final _formKey = GlobalKey<FormState>();
late Box<MatchDetails> matchdetailbox;
late List<MatchDetails> matchdetailList;

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final bool _isUserSigned = false;
  final bool _isAdminSigned = false;
  @override
  void initState() {
    matchdetailbox = Hive.box<MatchDetails>('matchdetails');
    matchdetailList = matchdetailbox.values.toList();
    super.initState();
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
              ValueListenableBuilder(
                  valueListenable: matchdetailbox.listenable(),
                  builder: (context, Box<MatchDetails> box, widget) {
                    matchdetailList = box.values.toList();
                    return SizedBox(
                      height: mediaHeight - 200, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: matchdetailList.length,
                        itemBuilder: (context, index) {
                          final match = matchdetailList[index];
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  Expanded(
                                      child: Text(
                                    match.team1,
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
                                    match.team2,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  SizedBox(
                                    width: mediaWidth * .1,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        // showEditingDialog(
                                        //     context,
                                        //     match,
                                        //     _formKey,
                                        //     mediaWidth,
                                        //     mediaHeight,
                                        //     setState);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditPage(
                                              match: match,
                                              context: context,
                                              setStateCallback: setState,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        //Repository.deleteData(match.matchKey);
                                        showDeleteConfirmationDialog(
                                            context, match.matchKey);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
      )),
    );
  }
}
