class Replays {
// ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? text;
  String? uid;
  String? token;
  String? commentname;

  String? commentimage;
  String? replayid;
  String? commentid;

  List<dynamic> replays = [];
  bool? show;

  Replays({
    this.datatime,
    this.uid,
    this.text,
    this.commentname,
    this.commentimage,
    this.replayid,
    required this.commentid,
    this.show,
    this.token,

    // this.islikes1
  });
  Replays.fromjason(
    Map<String, dynamic> json,
  ) {
    token = json['token'];
    commentname = json['commentname'];
    commentid = json['commentid'];
    show = json['show'];
    datatime = json['datatime'];
    text = json['text'];
    uid = json['uid'];
    replayid = json['replayid'];

    commentimage = json['commentimage'];
    if (json['replays'] != null) {
      json['replays'].forEach((elemnt) {
        replays.add(elemnt);
      });
    }
  }

  Map<String, dynamic> tomap() {
    return {
      'token': token,
      'commentname':commentname,
      'datatime': datatime,
      'text': text,
      'commentid': commentid,
      'uid': uid,
      'commentimage': commentimage,
      'replayid': replayid,
      'replays': replays,
      'show': show,
    };
  }
}
