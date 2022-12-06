class Comments {
// ignore: prefer_typing_uninitialized_variables
  late final datatime;
  String? text;
  String? uid;
  String? token;
  String? image;
  String? name;
  String? commentimage;
  String? commentid;
   dynamic gif;
  List<dynamic> comments = [];
  bool? show;

  

  Comments(
      {this.datatime,
      this.uid,
      this.image,
      this.text,
      this.name,
      this.commentimage,
      this.commentid,
      this.show,
      this.token,
      this.gif,

      // this.islikes1
      });
  Comments.fromjason(
    Map<String, dynamic> json,
  ) {
    name = json['name'];
     gif = json['gif'];
    token = json['token'];
    show = json['show'];
    datatime = json['datatime'];
    text = json['text'];
    uid = json['uid'];
    commentid = json['commentid'];
    image = json['image'];
    commentimage = json['commentimage'];
    if (json['comments'] != null) {
      json['comments'].forEach((elemnt) {
        comments.add(elemnt);
      });
    }
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'token': token,
      'datatime': datatime,
      'text': text,
      'uid': uid,
      'commentimage': commentimage,
      'image': image,
      'commentid': commentid,
      'comments': comments,
      'show': show,
      'gif' :gif,
    };
  }
}
