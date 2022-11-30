class GetPosts {
  String? name;
  // ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? text;
  String? uid;
  String? image;
  String? postimage;
  List<dynamic> likes = [];
  bool? show;
  int commentint = 0;
  String? token;
  String? postid;
  
  //int nbOfComments = 0;
  //bool? islikes1;

  GetPosts(
      {this.datatime,
      this.name,
      this.postimage,
      this.uid,
      this.image,
      this.text,
      this.commentint = 0,
      this.token,
      this.postid,
     

      // this.islikes1
      });
  GetPosts.fromjason(Map<String, dynamic> json) {
    name = json['name'];
    postid = json['postid'];
    
    commentint = json['commentint'];
    datatime = json['datatime'];
    text = json['text'];
    uid = json['uid'];
    postimage = json['postimage'];
    image = json['image'];
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
      'name': name,
      'datatime': datatime,
      'text': text,
      'uid': uid,
      'postimage': postimage,
      'image': image,
      //'nbOfLikes': nbOfLikes,
      'likes': likes,
      'show': show,
      'commentint': commentint,
      'token': token,
      'postid': postid,
      
    };
  }
}
