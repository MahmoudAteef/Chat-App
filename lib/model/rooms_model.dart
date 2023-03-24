class Rooms {
  // static const String collectionName = '';
  String id;
  String roomTitle;
  String roomDesc;
  String CategoryId;
  Rooms(
      {required this.id,
        required this.roomTitle,
        required this.roomDesc,
        required this.CategoryId});

  Map<String, dynamic> toJson() =>
      {'id': id, 'roomTitle': roomTitle, 'roomDesc': roomDesc, 'CategoryId': CategoryId};


  Rooms.fromJson(Map<String,dynamic>json):
        this(
          id: json['id'] as String,
          roomTitle: json['roomTitle'] as String,
          roomDesc: json['roomDesc'] as String,
          CategoryId: json['CategoryId'] as String);
}