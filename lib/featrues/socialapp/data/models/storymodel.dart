

class Story {
  String? name;
  String? userimage;
  String? uid;
  String? token;
  List<String> storyimage = [];
  // ignore: prefer_typing_uninitialized_variables
  late final datatime;
  List<String> capiton = [];
  List<dynamic> times = [];
  

  Story({
    this.userimage,
    this.name,
    this.datatime,
    this.token,
    this.uid,
    required this.storyimage,
    required this.capiton,
     required this.times,
  });
  Story.fromjason(
    Map<String, dynamic> json,
  ) {
    name = json['name'];
    
    datatime = json['datatime'];
    userimage = json['userimage'];
    uid = json['uid'];
    token = json['token'];
    if (json['storyimage'] != null) {
      json['storyimage'].forEach((elemnt) {
        storyimage.add(elemnt);
      });
    }
     if (json['capiton'] != null) {
      json['capiton'].forEach((elemnt) {
        capiton.add(elemnt);
      });
    }
    if (json['times'] != null) {
      json['times'].forEach((elemnt) {
        times.add(elemnt);
      });
    }
  }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'userimage': userimage,
      'datatime': datatime,
      'token': token,
      'uid': uid,
      'storyimage': storyimage,
      'capiton' :capiton,
      'times' :times,
      
    };
  }
}
