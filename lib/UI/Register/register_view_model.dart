import 'package:chat_app/UI/Register/navigator.dart';
import 'package:chat_app/base.dart';
import 'package:chat_app/firebase_errors.dart';
import 'package:chat_app/firebase_function.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator>{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void register(String fullname, String username, String email, String password) async {
    String? message;
    try {
      navigator?.showLoading();
     var result =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = MyUser(id: result.user?.uid??"", fullname: fullname, username: username, email: email);
      var task = FireStoreUtils.createUser(user);
      navigator?.goToLogin(user);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseErrors.emailInUse) {
        message = 'Email Provided already Exists';
      }else{
        message = 'Wrong email and password';
      }
    } catch (e) {
      message = e.toString();
    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }
  }
}