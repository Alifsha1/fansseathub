import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/userLoginScreen.dart';
import 'package:fansseathub/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final String? Function(String?)? validator;
  const SignupScreen({super.key, this.validator});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final bool _isUserSigned = false;
  final bool _isAdminSigned = false;
  // ignore: unused_field
  final bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Heading()],
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 555,
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
                              'Signup',
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
                              'Name',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                     
                          FormTextField(hinttext: 'name', validator:  (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return "name cannot be empty";
                              }
                            }, onChanged: (val) {
                              setState(() {
                                fullName = val;
                              });
                            }),
                          const Padding(
                            padding: EdgeInsets.only(top: 4, left: 5),
                            child: Text(
                              'Email',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                      
                          FormTextField(hinttext: 'gmail', validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter a valid email";
                            }, onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            }),
                          const Padding(
                            padding: EdgeInsets.only(top: 4, left: 5),
                            child: Text(
                              'password',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          
                          FormTextField(hinttext: 'password', validator:(val) {
                              if (val!.length < 6) {
                                return "password must be at least 6 characters";
                              } else {
                                return null;
                              }
                            }, onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            }),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: ElevatedButton(
                              onPressed: () {
                                signup(
                                    formkey,
                                    setState,
                                    _isLoading,
                                    authService,
                                    fullName,
                                    email,
                                    password,
                                    context,
                                    _isUserSigned,
                                    _isAdminSigned);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
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
                                            const UserLoginScreen(),
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
                        ],
                      ),
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
