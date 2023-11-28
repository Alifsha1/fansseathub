import 'package:fansseathub/helper/helper_functions.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

//======Register=====
  Future signupUserWithEmailandPassword(
      String name, String email, String password, BuildContext context) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        await DatabaseService(uid: user.uid).savingUserData(name, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        showSnackbar(context, Colors.red, 'Email already in use');
      }
      debugPrint(e.code);
      return e.message;
    }
  }

  //======signout=====
  Future signout() async {
    try {
      await HelperFunction.saveUSerLoggedInStatus(false);
      await HelperFunction.saveUSerEmailSF("");
      await HelperFunction.saveUSerNameSF("");
      await HelperFunction.saveAdminLoggedInStatus(false);
      await HelperFunction.saveAdminEmailSF("");
      firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
