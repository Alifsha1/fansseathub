import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userloggedInkey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailkey = "USEREMAILKEY";

  static Future<bool> saveUSerLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userloggedInkey, isUserLoggedIn);
  }

  static Future<bool> saveUSerNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUSerEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailkey, userEmail);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userloggedInkey);
  }

  static String adminloggedInkey = "ADMINLOGGEDINKEY";
  static String adminEmailkey = "ADMINEMAILKEY";

  static Future<bool> saveAdminLoggedInStatus(bool isAdminLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(adminloggedInkey, isAdminLoggedIn);
  }

  static Future<bool> saveAdminEmailSF(String adminEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(adminEmailkey, adminEmail);
  }

  static Future<bool?> getAdminLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(adminloggedInkey);
  }
}
