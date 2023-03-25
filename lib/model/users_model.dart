class MyUser {
  static const String collectionName = 'Users';
  String id;
  String fullname;
  String username;
  String email;
  MyUser(
      {required this.id,
        required this.fullname,
        required this.username,
        required this.email});

  Map<String, dynamic> toJson() =>
      {'id': id, 'fullname': fullname, 'username': username, 'email': email};


  MyUser.fromJson(Map<String,dynamic>json):
        this(
          id: json['id'] as String,
          fullname: json['fullname'] as String,
          username: json['username'] as String,
          email: json['email'] as String);
}