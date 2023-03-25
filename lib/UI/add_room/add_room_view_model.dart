import 'package:chat_app/UI/add_room/navigator.dart';
import 'package:chat_app/base.dart';
import '../../firebase_function.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator>{
  void createRoom(String roomTitle, String roomDesc, String CategoryId) async {
    String? message=null;
    try {
      var res = FireStoreUtils.createRoom(roomTitle,roomDesc,CategoryId);
      navigator?.showLoading();
    }catch (e) {
      message = e.toString();
    }
    if(message!=null){
      navigator?.showMessage(message);
    }else{
      navigator?.roomCreated();
    }
  }

}

