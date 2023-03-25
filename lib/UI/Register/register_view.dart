
import 'package:chat_app/UI/Login/login_view.dart';
import 'package:chat_app/UI/Register/navigator.dart';
import 'package:chat_app/UI/Register/register_view_model.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:chat_app/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base.dart';
import '../Home/home_view.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView,RegisterViewModel>implements RegisterNavigator{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String fullname = '';
  String username = '';
  String email = '';
  String password = '';

@override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.18,
                      ),
                      TextFormField(
                        onChanged: (text) {
                          fullname = text;
                        },
                        decoration: const InputDecoration(labelText: 'Full name'),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter full name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        onChanged: (text) {
                          username = text;
                        },
                        decoration: const InputDecoration(labelText: 'Username'),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter username';
                          }
                          if (text.contains(" ")) {
                            return 'username must not contains spaces';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        onChanged: (text) {
                          email = text;
                        },
                        decoration:
                            const InputDecoration(labelText: 'E-mail Address'),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'email format not valid';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        onChanged: (text) {
                          password = text;
                        },
                        decoration: const InputDecoration(labelText: 'Password'),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter password';
                          }
                          if (text.length < 8) {
                            return 'Password should be at least 8 chars';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: const Text('Create Account'),
                      ),
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Divider(
                                  indent: 20.0,
                                  endIndent: 10.0,
                                  thickness: 1,
                                ),
                              ),
                              Text(
                                "already have an account",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Divider(
                                  indent: 10.0,
                                  endIndent: 20.0,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                        // style: ElevatedButton.styleFrom(backgroundColor: Colors.white,side: BorderSide(width: 1,color: Colors.blue),elevation: 0),
                        onPressed: () {
                          Navigator.pushNamed(context, loginView.routeName);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterView()));
                        },
                        child: const Text('Log in',style: TextStyle(color: Colors.blue),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(fullname,username,email, password);
    }
  }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  void goToLogin(MyUser user) {
  var userProvider = Provider.of<UserProvider>(context,listen: false);
  userProvider.user = user;
    Navigator.of(context).pushReplacementNamed('Home');
  showMessage('Registration Successful');

  }

}
