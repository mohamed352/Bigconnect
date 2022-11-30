class Notifications {
  String? name;
  // ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? uid;
  String? image;
  String? frienduid;
  String? notfiid;
  String? bio;
  int? notiint;
  String? check;
  String? token;

  Notifications({
    this.name,
    this.notfiid,
    this.image,
    this.datatime,
    this.uid,
    this.frienduid,
    this.notiint,
    this.check,
    this.token,
   required this.bio
  });
  Notifications.fromjason(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    token = json['token'];
    datatime = json['datatime'];
    uid = json['uid'];
    frienduid = json['frienduid'];
    notfiid = json['notfiid'];
    notiint = json['notiint'];
    image = json['image'];
    check = json['check'];
  }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'frienduid': frienduid,
      'datatime': datatime,
      'notfiid': notfiid,
      'notiint': notiint,
      'check': check,
      'token' :token,
      'bio' : bio,
    };
  }
}
