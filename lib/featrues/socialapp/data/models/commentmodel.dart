class Comments {
// ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? text;
  String? uid;
  String? token;

  String? commentimage;
  String? commentid;

  List<dynamic> comments = [];
  bool? show;

  Comments({
    this.datatime,
    this.uid,
    this.text,
    this.commentimage,
    this.commentid,
    this.show,
    this.token,

    // this.islikes1
  });
  Comments.fromjason(
    Map<String, dynamic> json,
  ) {
    token = json['token'];
    show = json['show'];
    datatime = json['datatime'];
    text = json['text'];
    uid = json['uid'];
    commentid = json['commentid'];

    commentimage = json['commentimage'];
    if (json['comments'] != null) {
      json['comments'].forEach((elemnt) {
        comments.add(elemnt);
      });
    }
  }

  Map<String, dynamic> tomap() {
    return {
      'token': token,
      'datatime': datatime,
      'text': text,
      'uid': uid,
      'commentimage': commentimage,
      'commentid': commentid,
      'comments': comments,
      'show': show,
    };
  }
}
