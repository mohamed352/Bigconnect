class UserData {
  String? name;
  String? phone;
  String? email;
  String? uid;
  bool? isEmailferivied;
  String? image;
  String? bio;
  String? cover;
  String? token;
  // ignore: prefer_typing_uninitialized_variables
  late final time;
  List<dynamic> friendsRquest = ['Start'];
  List<dynamic> friends = [];
  String? notifiuid;
  String? locaiton;
  String? education;
  String? socialsituation;
  UserData(
      {this.email,
      this.name,
      this.phone,
      this.uid,
      this.isEmailferivied,
      this.image,
      this.bio,
      this.cover,
      this.token,
      this.time,
      required this.friends});
  UserData.fromjason(Map<String, dynamic> json) {
    name = json['name'];
    time = json['time'];
    phone = json['phone'];
    notifiuid = json['notifiuid'];
    locaiton = json['locaiton'];
    education = json['education'];
    socialsituation = json['socialsituation'];
    email = json['email'];
    uid = json['uid'];
    isEmailferivied = json['isEmailferivied'];

    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    token = json['token'];
    if (json['friends'] != null) {
      json['friends'].forEach((element) {
        friends.add(element);
      });
    }
    if (json['friendsRquest'] != null) {
      json['friendsRquest'].forEach((element) {
        friendsRquest.add(element);
      });
    }
  }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uid,
      'isEmailferivied': isEmailferivied,
      'image': image,
      'bio': bio,
      'cover': cover,
      'friends': friends,
      'token': token,
      'friendsRquest': friendsRquest,
      'notifiuid': notifiuid,
      'socialsituation': socialsituation,
      'locaiton': locaiton,
      'education': education,
      'time' : time,
    };
  }
}
