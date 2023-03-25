import 'package:chat_app/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/message_model.dart';

class MessageWidget extends StatelessWidget {

  Message message;
  MessageWidget(this.message);
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return userProvider.user?.id == message.senderId? sentMessage(message):recievedMessage(message);
  }
}

class sentMessage extends StatelessWidget{
  Message message;
  sentMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
                color: Colors.blue,
              ),
              child: Text(message.content,style: TextStyle(color: Colors.white),)),
          Text(message.dateTime.toString()),
        ],
      ),
    );
  }
}

class recievedMessage extends StatelessWidget{
  Message message;
  recievedMessage(this.message);
  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(message.dateTime.toString()),
           Container(
               padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                 color: Colors.blue,
               ),
               child: Text(message.content,style: TextStyle(color: Colors.white),)),

         ],
       ),
     );
  }

}
