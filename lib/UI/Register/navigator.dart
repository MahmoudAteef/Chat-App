import 'package:chat_app/base.dart';
import 'package:chat_app/model/users_model.dart';

abstract class RegisterNavigator extends BaseNavigator{
void goToLogin(MyUser myUser);
}