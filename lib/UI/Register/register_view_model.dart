import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/firebase_function.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void register(String fullname, String username, String email, String password,
      BuildContext context) async {
    try {
     var result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await FirebaseAuth.instance.currentUser?.updateDisplayName(fullname);
      // await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      // await FirebaseAuth.instance.currentUser?.updateEmail(email);
      var user = MyUser(id: result.user?.uid??"", fullname: fullname, username: username, email: email);
      FireStoreUtils.createUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')));
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == FirebaseErrors.emailInUse) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}