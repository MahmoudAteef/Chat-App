import 'package:flutter/material.dart';
import '../../firebase_function.dart';
import '../../model/rooms_model.dart';

class HomeViewModel extends ChangeNotifier{
  List<Rooms>rooms =[];

  HomeViewModel(){
    getRooms();
  }


void getRooms()async{
  rooms = await FireStoreUtils.getRoomsFromFireStore();

}
}