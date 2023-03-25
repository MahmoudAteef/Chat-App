import 'package:chat_app/UI/Home/home_view.dart';
import 'package:chat_app/UI/Login/login_view.dart';
import 'package:chat_app/UI/Register/register_view.dart';
import 'package:chat_app/UI/add_room/add_room.dart';
import 'package:chat_app/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Chat/chat_view.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider())
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: userProvider.firebaseUser==null? loginView.routeName:HomeView.routeName,
      routes: {
        RegisterView.routeName : (_) =>  RegisterView(),
        loginView.routeName : (_) =>  loginView(),
        HomeView.routeName : (_) =>  HomeView(),
        AddRoomView.routeName : (_) =>  AddRoomView(),
        ChatView.routeName : (_) =>  ChatView()
      },
    );
  }
}