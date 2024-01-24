// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fansseathub/screen/favorites.dart';
import 'package:fansseathub/screen/hightlightsAdd.dart';
import 'package:fansseathub/screen/homeScreen.dart';
import 'package:fansseathub/screen/nxtGameAdding.dart';
import 'package:fansseathub/screen/profileScreen.dart';
import 'package:fansseathub/screen/settings.dart';
import 'package:fansseathub/screen/stadiumDetailsScreen.dart';
import 'package:fansseathub/sections/assets.dart';
import 'package:fansseathub/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message ?? '',
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "ok",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'FansSeatHub',
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: "Miltonian_Tattoo",
          color: Colors.black),
    );
  }
}

class HeadingWhite extends StatelessWidget {
  const HeadingWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'FansSeatHub',
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: "Miltonian_Tattoo",
          color: Colors.white),
    );
  }
}

class ButtonElevated extends StatelessWidget {
  final String buttonText;
  const ButtonElevated({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ));
  }
}

class AdminSideHeadings extends StatelessWidget {
  final String headings;
  const AdminSideHeadings({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Text(
      headings,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AdminSideHeadingsBlack extends StatelessWidget {
  final String headings;
  const AdminSideHeadingsBlack({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Text(
      headings,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AdminSideHeadingsBlackSize extends StatelessWidget {
  final String headings;
  const AdminSideHeadingsBlackSize({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Text(
      headings,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class StadiumText extends StatelessWidget {
  final String standname;
  const StadiumText({super.key, required this.standname});

  @override
  Widget build(BuildContext context) {
    return Text(
      standname,
      style: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class AdminTextField extends StatelessWidget {
  final String errormessage;
  final String? Function(String?)? validator;
  final String hinttext;
  final TextEditingController controller;
  const AdminTextField(
      {super.key,
      required this.hinttext,
      this.validator,
      required this.controller,
      required this.errormessage});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: hinttext,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return errormessage;
        }
      },
    );
  }
}

// ignore: must_be_immutable
class FormTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String hinttext;
  TextEditingController? controller;
  // String text;
  void Function(String)? onChanged;
  FormTextField(
      {super.key,
      required this.hinttext,
      required this.validator,
      required this.onChanged,
      this.controller
      // required this.text,
      });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: 'gmail',
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: widget.onChanged,
      //(value) {
      //   setState(() {
      //     widget.text = value;
      //   });
      // },
      validator: widget.validator,
    );
  }
}

drawerAdminScreen(
  context,
  mediaWidth,
  isAdminSigned,
  isUserSigned,
  authService,
) {
  return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 65,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.black,
                  )),
              SizedBox(
                width: mediaWidth * .04,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          idAdminSigned: isAdminSigned,
                          isUserSigned: isUserSigned,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 65,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddNextGame(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
              SizedBox(
                width: mediaWidth * .04,
              ),
              const Text(
                '+Add Next Game',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 65,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddStadiumDetails(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
              SizedBox(
                width: mediaWidth * .04,
              ),
              const Text(
                'AddDetails',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 65,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddHighlights(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
              SizedBox(
                width: mediaWidth * .04,
              ),
              const Text(
                'Addvideos',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 65,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  )),
              SizedBox(
                width: mediaWidth * .04,
              ),
              const Text(
                'settings',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 68),
          child: Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await authService.showSignOutConfirmationDialog(context);
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                  )),
              SizedBox(
                width: mediaWidth * .04,
              ),
              GestureDetector(
                onTap: () {},
                child: InkWell(
                  onTap: () async {
                    await authService.showSignOutConfirmationDialog(context);
                    // ignore: use_build_context_synchronously
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Divider(
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Color.fromARGB(255, 163, 160, 160),
          ),
        ),
      ],
    ),
  );
}

drawerUserScreen(context, mediaWidth, authService, username, email) {
  final userDataStream = DatabaseService().getUserDetails(
      FirebaseAuth.instance.currentUser?.uid ?? 'XzO7r4F9bvU95bLggJdOQ0S3qhl1');
  return StreamBuilder(
      stream: userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userDataSnapshot =
              snapshot.data?.data() as Map<String, dynamic>;
          final String userProfilePic = userDataSnapshot['profilepic'];
          print('obj: $userProfilePic');
          return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: ClipOval(
                      child: userProfilePic.isNotEmpty
                          ? Image.network(
                              userProfilePic,
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
                            )
                          : Icon(
                              Icons.person,
                              size: 150,
                            )
                      //Image.asset(crik)
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  username,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 65,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.home,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: mediaWidth * .04,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Home',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 65,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                      email: email, username: username)),
                            );
                          },
                          icon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: mediaWidth * .04,
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 65,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: mediaWidth * .04,
                      ),
                      const Text(
                        'settings',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 65,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            print('favv');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => favorites()),
                            );
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: mediaWidth * .04,
                      ),
                      const Text(
                        'Favorites',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: mediaWidth * .04,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: InkWell(
                          onTap: () async {
                            await authService
                                .showSignOutConfirmationDialog(context);
                            // ignore: use_build_context_synchronously
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: Color.fromARGB(255, 163, 160, 160),
                  ),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      });
}
