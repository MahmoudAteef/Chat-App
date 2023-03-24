import 'package:chat_app/base.dart';
import 'package:chat_app/firebase_function.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/rooms_model.dart';
import '../model/users_model.dart';

class ChatViewModel extends BaseViewModel<ChatScreenNavigator>{
  late Rooms rooms;
  late MyUser currentUser;
  late Stream<QuerySnapshot<Message>>messagesStream;
  void sendMessage(String messageContent,context)async{
    if(messageContent.trim().isEmpty){
      return;
    } var message = Message(roomId: rooms.id, content: messageContent, dateTime: DateTime.now().microsecondsSinceEpoch, senderId: currentUser.username, senderName: currentUser.id);
    try {
    var res = await FireStoreUtils.insertMessageToRoom(message);
    navigator?.clearMessageText();
    }catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  void listenForRoomUpdate(){
    messagesStream = FireStoreUtils.getMessagesStream(rooms.id);
  }
}



abstract class ChatScreenNavigator extends BaseNavigator{
  void clearMessageText();
}

