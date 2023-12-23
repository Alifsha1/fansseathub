import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/userLoginScreen.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final formkey = GlobalKey<FormState>();
  String adminEmail = "";
  String adminPassword = "";
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Heading()],
              ),
              const SizedBox(
                height: 110,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(35)),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 1),
                          child: Text(
                            'Admin Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2, left: 5),
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        TextFormField(
                          controller: adminEmailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            hintText: 'gmail',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (val) {
                            setState(() {
                              adminEmail = val;
                            });
                          },
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4, left: 5),
                          child: Text(
                            'password',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        TextFormField(
                          controller: adminpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            hintText: 'password',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              adminPassword = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: ElevatedButton(
                              onPressed: () {
                                if (adminEmailController.text.isNotEmpty &&
                                    adminpasswordController.text.isNotEmpty) {
                                  adminlogin(context, adminEmailController.text,
                                      adminpasswordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UserLoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
