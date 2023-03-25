import 'package:flutter/material.dart';
import '../../model/rooms_model.dart';
import '../Chat/chat_view.dart';


class RoomWidget extends StatelessWidget {
  Rooms rooms;
  RoomWidget(this.rooms);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatView.routeName , arguments: rooms);
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        margin: const EdgeInsets.only(left: 20,right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/${rooms.categoryId}.png',
                  width: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.fitWidth,
                )),
            Text(rooms.roomTitle, style: const TextStyle(color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
