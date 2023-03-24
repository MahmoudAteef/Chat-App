import 'package:chat_app/Chat/chat_view.dart';
import 'package:chat_app/UI/Home/home_view.dart';
import 'package:chat_app/UI/Login/login_view.dart';
import 'package:chat_app/UI/Register/register_view.dart';
import 'package:chat_app/UI/add_room/add_room.dart';
import 'package:chat_app/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider())
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: UserProvider==null ?loginView.routeName:HomeView.routeName,
      // initialRoute: RegisterView.routeName,
      routes: {
        RegisterView.routeName : (_) => const RegisterView(),
        loginView.routeName : (_) => const loginView(),
        HomeView.routeName : (_) => const HomeView(),
        AddRoomView.routeName : (_) => const AddRoomView(),
        ChatView.routeName : (_) => const ChatView()
      },
    );
  }
}