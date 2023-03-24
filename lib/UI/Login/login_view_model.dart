import 'package:chat_app/UI/Home/home_view.dart';
import 'package:chat_app/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void login(String email, String password, BuildContext context) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, HomeView.routeName);
      // FireStoreUtils.readUser(result.user!.uid??"");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You are Logged in')));
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.userNotFound) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('no user found with this Email')));
      } else if (e.code == FirebaseErrors.wrongPass) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password did not match')));
      }
    }
  }
}
