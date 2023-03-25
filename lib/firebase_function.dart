import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/rooms_model.dart';

class FireStoreUtils {

  static Future<void>createUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }
  static CollectionReference<MyUser> getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).withConverter<MyUser>(
        fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  static Future<MyUser?>readUser(String userId) async {
    var userDocSnapshot = await getUserCollection().doc(userId).get();
    return userDocSnapshot.data();
  }



  static Future<void> createRoom(String roomTitle, String roomDesc, String categoryId) async {
    var roomCollection = getRoomCollection();
    var decRef = roomCollection.doc();
    Rooms room = Rooms(
        id: decRef.id,
        roomTitle: roomTitle,
        roomDesc: roomDesc,
        categoryId: categoryId);
    return decRef.set(room);
  }
  static CollectionReference<Rooms> getRoomCollection() {
    return FirebaseFirestore.instance.collection(Rooms.collectionName).withConverter<Rooms>(
        fromFirestore: (snapshot, _) => Rooms.fromJson(snapshot.data()!),
        toFirestore: (room, _) => room.toJson());
  }

  static Future<List<Rooms>> getRoomsFromFireStore() async {
    var qsnapshot = await getRoomCollection().get();
    return qsnapshot.docs.map((doc) => doc.data()).toList();
  }



  static Future<void> insertMessageToRoom(Message message)async{
    var roomMessages = getMessagesCollection(message.roomId);
    var docRef = roomMessages.doc();
    message.id = docRef.id;
    return docRef.set(message);

}
  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return getRoomCollection()
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
        fromFirestore: (snapshot, _) =>
            Message.fromFireStore(snapshot.data()!),
        toFirestore: (message, _) => message.toFireStore());
  }

  static Stream<QuerySnapshot<Message>>getMessagesStream(String roomId){
    return getMessagesCollection(roomId).orderBy('dateTime').snapshots();
}






}
