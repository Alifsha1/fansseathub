import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/adminLoginScreen.dart';
import 'package:fansseathub/screen/forgetScreen.dart';
import 'package:fansseathub/screen/signupScreen.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final bool isUserSigned = false;
  final bool isAdminSigned = false;
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  // ignore: unused_field
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const AdminLoginScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Heading()],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 460,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: const EdgeInsets.all(27.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2, left: 5),
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        FormTextField(
                          hinttext: 'gmail',
                          onChanged: (val) {
                            setState(() {
                              email = val;
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
                        const Padding(
                          padding: EdgeInsets.only(top: 4, left: 5),
                          child: Text(
                            'password',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        FormTextField(
                          hinttext: 'password',
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          validator: (val) {
                            if (val!.length < 6) {
                              return "password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: ElevatedButton(
                            onPressed: () {
                              login(formkey, setState, _isLoading, authService,
                                  email, password, context, isAdminSigned);
                              //login();
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
                        const SizedBox(
                          height: 6,
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do not have an account?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 18),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'forgot password?',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
