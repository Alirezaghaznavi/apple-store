import 'package:apple_store/di/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _sharedPref = locatore.get();
  static final ValueNotifier<String?> authChangenotifire = ValueNotifier(null);

  static void saveToken(String token) async {
    await _sharedPref.setString('access_token', token);
    authChangenotifire.value = token;
  }

//   static String readAuth() {
//     return _sharedPref.getString('access_token') ?? '';
//   }

//   static void logout() async {
//     await _sharedPref.clear();
//     authChangenotifire.value = null;
//   }

//   static bool isLogedin() {
//     String token = readAuth();
//     return token.isNotEmpty;
//   }
 }
