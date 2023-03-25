import 'package:chat_app/UI/Home/navigator.dart';
import 'package:chat_app/base.dart';
import '../../firebase_function.dart';
import '../../model/rooms_model.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{
  List<Rooms>rooms =[];

  // HomeViewModel(){
  //   getRooms();
  // }


void getRooms()async{
  rooms = await FireStoreUtils.getRoomsFromFireStore();
}
}