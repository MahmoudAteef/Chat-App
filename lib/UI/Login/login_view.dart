import 'package:chat_app/UI/Home/home_view.dart';
import 'package:chat_app/UI/Login/navigator.dart';
import 'package:chat_app/base.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../user_provider.dart';
import '../Register/register_view.dart';
import 'login_view_model.dart';

class loginView extends StatefulWidget {

static const String routeName = 'Login';

  @override
  State<loginView> createState() => _loginViewState();
}
class _loginViewState extends BaseState<loginView,LoginViewModel> implements LoginNavigator{

  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  String email = '';
  String password = '';

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
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey2,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                      const Text('Welcome Back!',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      TextFormField(
                        // key: ValueKey('email'),
                        onChanged: (text) {
                          email = text;
                        },
                        decoration:
                        const InputDecoration(labelText: 'Email'),
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
                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                      const Text('Forgot password?'),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      ElevatedButton(
                        onPressed: () {
                          validateForm1();
                        },
                        child: const Text('Login'),
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
                                "First time using Chat Now",
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
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),),
                        // style: ElevatedButton.styleFrom(backgroundColor: Colors.white,side: BorderSide(width: 1,color: Colors.blue),elevation: 0),
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.routeName);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterView()));
                        },
                        child: const Text('Create an account',style: TextStyle(color: Colors.blue),),
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

void validateForm1() {
  if (formKey2.currentState?.validate() == true) {
    viewModel.login(email, password);
  }
}

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user;
    Navigator.pushReplacementNamed(context, HomeView.routeName);
    showMessage('You are Logged in');

  }
}
