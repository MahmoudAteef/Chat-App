import 'package:chat_app/UI/Home/home_view_model.dart';
import 'package:chat_app/UI/Home/navigator.dart';
import 'package:chat_app/UI/Home/room_widget.dart';
import 'package:chat_app/UI/Login/login_view.dart';
import 'package:chat_app/UI/add_room/add_room.dart';
import 'package:chat_app/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
static const String routeName = 'Home';


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView,HomeViewModel> implements HomeNavigator{

@override
  void initState() {
    super.initState();
    viewModel.getRooms();
    viewModel.navigator = this;
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
              actions: [
                InkWell(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, loginView.routeName);
                    },
                    child: Icon(Icons.logout))
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Chat App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),onPressed: (){
              Navigator.pushNamed(context, AddRoomView.routeName);
            },),
            body: Column(children: [
              Expanded(child: Consumer<HomeViewModel>(
                builder: (buildContext,homeViewmodel,child){
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.3),
                    itemBuilder: (_,index){
                      return RoomWidget(homeViewmodel.rooms[index]);
                    },
                    itemCount: homeViewmodel.rooms.length,
                  );
                },
              ))
            ],),
          )
        ],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
  return HomeViewModel();
  }
}
