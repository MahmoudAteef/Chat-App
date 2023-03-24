import 'package:flutter/material.dart';
import '../../firebase_function.dart';

class AddRoomViewModel extends ChangeNotifier {
  void createRoom(String roomTitle, String roomDesc, String CategoryId,
      BuildContext context) async {
    try {
      var res = await FireStoreUtils.createRoom(roomTitle,roomDesc,CategoryId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Room Created')));
    }catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

}

