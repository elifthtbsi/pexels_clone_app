import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? username;
  String? password;

  void setUser(String newUsername, String newPassword) {
    username = newUsername;
    password = newPassword;
    notifyListeners();
  }
}
