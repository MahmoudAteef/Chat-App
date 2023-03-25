import 'package:chat_app/UI/Login/navigator.dart';
import 'package:chat_app/base.dart';
import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/firebase_function.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void login(String email, String password) async {
    String? message;
    try {
      navigator?.showLoading();
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      var userObj = await FireStoreUtils.readUser(result.user?.uid??"Error");
        navigator?.goToHome(userObj!);
        // message = 'You are Logged in';

    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.userNotFound) {
        message = 'no user found with this Email';
      } else if (e.code == FirebaseErrors.wrongPass) {
        message = 'Password did not match';
      }else{
        message = 'Wrong email and password';
      }
    }catch (e) {
      message = e.toString();
    }
    if(message!=null){
      navigator?.showMessage(message);
    }
  }
}
