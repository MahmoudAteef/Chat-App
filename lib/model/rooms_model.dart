class Rooms {
  static const String collectionName = 'Rooms';
  String id;
  String roomTitle;
  String roomDesc;
  String categoryId;
  Rooms(
      {required this.id,
        required this.roomTitle,
        required this.roomDesc,
        required this.categoryId});

  Map<String, dynamic> toJson() =>
      {'id': id, 'roomTitle': roomTitle, 'roomDesc': roomDesc, 'categoryId': categoryId};


  Rooms.fromJson(Map<String,dynamic>json):
        this(
          id: json['id'] as String,
          roomTitle: json['roomTitle'] as String,
          roomDesc: json['roomDesc'] as String,
          categoryId: json['categoryId'] as String);
}