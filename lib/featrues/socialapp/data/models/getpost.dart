class GetPosts {
  // ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? text;
  String? uid;
  bool? vip;
  String? postimage;
  List<dynamic> likes = [];
  bool? show;
  int commentint = 0;
  String? token;
  String? postid;

  //int nbOfComments = 0;
  //bool? islikes1;

  GetPosts({
    this.datatime,
    this.postimage,
    this.uid,
    this.text,
    this.commentint = 0,
    this.token,
    this.postid,
   required this.vip,
    

    // this.islikes1
  });
  GetPosts.fromjason(Map<String, dynamic> json) {
    postid = json['postid'];
    vip = json['vip'];

    commentint = json['commentint'];
    datatime = json['datatime'];
    text = json['text'];
    uid = json['uid'];
    postimage = json['postimage'];

    show = json['show'];
    token = json['token'];

    //  nbOfLikes = json['nbOfLikes'] as int;
    if (json['likes'] != null) {
      json['likes'].forEach((element) {
        likes.add(element);
      });
    }

    //islikes1 = json['islikes1'];
  }

  Map<String, dynamic> tomap() {
    return {
      'datatime': datatime,
      'text': text,
      'vip' :vip,
      'uid': uid,
      'postimage': postimage,

      //'nbOfLikes': nbOfLikes,
      'likes': likes,
      'show': show,
      'commentint': commentint,
      'token': token,
      'postid': postid,
    };
  }
}
