class Friends {
  String? name;
  // ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? uid;
  String? image;
  String? friendsId;
  String? bio;
  List<dynamic> friends = [];
  Friends({
    this.name,
    this.friendsId,
    this.image,
    this.datatime,
    this.uid,
    this.bio
  });
  Friends.fromjason(Map<String, dynamic> json) {
   name = json['name'];
    bio = json['bio'];
    datatime = json['datatime'];
    uid = json['uid'];

    friendsId = json['friendsId'];

    image = json['image'];
    if (json['friends'] != null) {
      json['friends'].forEach((elemnt) {
        friends.add(elemnt);
      });}
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'datatime': datatime,
      'friendsId': friendsId,
      'friends':friends,
      'bio' :bio,
    };
  }
}
