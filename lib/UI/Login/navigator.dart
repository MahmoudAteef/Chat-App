import 'package:chat_app/base.dart';
import 'package:chat_app/model/users_model.dart';

abstract class LoginNavigator extends BaseNavigator{
  void goToHome(MyUser myUser);
}