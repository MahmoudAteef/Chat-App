import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/model/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/rooms_model.dart';

// addming multi users without json & map
// class FirestoreServices {
//   static createUser(String fullname,String username,String email,uid)async{
//     await FirebaseFirestore.instance.collection('users').doc(uid).set(
//         {'fullname': fullname, 'username': username, 'email': email});
//   }
// }

// adding only one ID with json
// Future createUser(String fullname,String username,String email)async{
//   final docUser = await FirebaseFirestore.instance.collection('users').doc('user-id');
//
//   final json = {
//     'fullname': fullname, 'username': username, 'email': email
//   };
//   await docUser.set(json);
// }

// create multi rooms but i can't get data for Home
// Future createRoom(String roomTitle, String roomDesc, String CategoryId) async {
//   final docRoom = await FirebaseFirestore.instance.collection('rooms').doc();
//   final room = Room(
//       id: docRoom.id,
//       roomTitle: roomTitle,
//       roomDesc: roomDesc,
//       CategoryId: CategoryId);
//   final json = room.toJson();
//   await docRoom.set(json);
// }

// static Future<void> createRoom(String roomTitle, String roomDesc, String CategoryId) async {
//   final roomsCollection = getRoomCollection();
//   final docRef = roomsCollection.doc();
//   Room room =Room(id: docRef.id, roomTitle: roomTitle, roomDesc: roomDesc, CategoryId: CategoryId);
//   return docRef.set(room);
// }

class FireStoreUtils {
  static Future createUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }
  static readUser(String userId) async {
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
  static Future<void> insertMessageToRoom(Message message)async{
    var roomMessages = getMessagesCollection(message.roomId);
    var docRef = roomMessages.doc();
    message.id = docRef.id;
    return docRef.set(message);

}
  static Stream<QuerySnapshot<Message>>getMessagesStream(String roomId){
    return getMessagesCollection(roomId).orderBy('dateTime').snapshots();
}



  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
        fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson());
  }
  static CollectionReference<Rooms> getRoomCollection() {
    return FirebaseFirestore.instance.collection('rooms').withConverter<Rooms>(
        fromFirestore: (snapshot, _) => Rooms.fromJson(snapshot.data()!),
        toFirestore: (room, _) => room.toJson());
  }
  static Future<List<Rooms>> getRoomsFromFireStore() async {
    var qsnapshot = await getRoomCollection().get();
    return qsnapshot.docs.map((doc) => doc.data()).toList();
  }
  static CollectionReference<Message> getMessagesCollection(String roomId) {
    return getRoomCollection()
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                Message.fromFireStore(snapshot.data()!),
            toFirestore: (message, _) => message.toFireStore());
  }
}
