import 'package:chat_app/firebase_function.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (firebaseUser != null) {
      user = await FireStoreUtils.readUser(firebaseUser?.uid ?? "");
    }
  }
}
