import 'package:chat_app/Chat/chat_view_model.dart';
import 'package:chat_app/base.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/model/rooms_model.dart';
import 'package:chat_app/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  static const String routeName = 'Chat';

  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView, ChatViewModel>
    implements ChatScreenNavigator {
  // ChatViewModel viewModel = ChatViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  String messageContent = '';
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Rooms room = ModalRoute.of(context)?.settings.arguments as Rooms;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.rooms = room;
    viewModel.currentUser = userProvider.user!;
    viewModel.listenForRoomUpdate();
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                room.roomTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.all(25),
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
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                        stream: viewModel.messagesStream,
                        builder: (_,snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(child: CircularProgressIndicator());
                          }else if(snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()),);
                          }
                          var messages =  (snapshot.data?.docs.map((doc) => doc.data()).toList());
                          messages?.forEach((element){print(element);});

                          return ListView.builder(itemBuilder: (_,i){
                            return Text(messages?.elementAt(i).content??"");
                          },itemCount: messages?.length??0,);
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            onChanged: (text) {
                              messageContent = text;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10)),
                                    borderSide: BorderSide(color: Colors.grey)),
                                hintText: 'Type a message'),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              viewModel.sendMessage(messageContent, context);
                            },
                            child: Row(
                              children: const [
                                Text('Send'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.send)
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void clearMessageText() {
    textController.clear();
  }

  @override
  ChatViewModel initViewModel() => ChatViewModel();
}
