import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/cashehelper.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/data/models/commentmodel.dart';
import 'package:socialapp/featrues/socialapp/data/models/friends.dart';
import 'package:socialapp/featrues/socialapp/data/models/getpost.dart';
import 'package:socialapp/featrues/socialapp/data/models/notifications.dart';
import 'package:socialapp/featrues/socialapp/data/models/storymodel.dart';
import 'package:socialapp/featrues/socialapp/data/models/userdata.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/Notfications/notficatios.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/feeds/feeds.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/menu/menu.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/splach/presatoitons/splachview.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/story/ceratstory.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';
import 'package:uuid/uuid.dart';

part 'socialapp_state.dart';

class SocialappCubit extends Cubit<SocialappState> {
  SocialappCubit() : super(SocialappInitial());
  static SocialappCubit get(context) => BlocProvider.of(context);

  UserData? usermodel;
  List<UserData> userlist = [];
  void getuserdata({String? uid}) {
    if (uid != null || uidforall != null) {
      emit(SocialappGetUserLoading());
      try {
        FirebaseFirestore.instance
            .collection('users')
            .snapshots()
            .listen((event) {
          for (var element in event.docs) {
            if (element.data()['uid'] == uidforall ||
                element.data()['uid'] == uid) {
              usermodel = UserData.fromjason(element.data());
              userlist.add(UserData.fromjason(element.data()));
              emit(SocialappGetUserScsues());
            }
          }
        });
      } catch (error) {
        emit(SocialappGetUserError(error.toString()));
        if (kDebugMode) {
          print(error.toString());
        }
      }
    }
  }

  Future<void> sendemailverfiy(context) async {
    emit(SocialappSendEmailLoading());

    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      showSnackBar(
        context: context,
        text: 'Verfiy send check your mail spam folder',
      );
      emit(SocialappSendEmailscsufly());
    } catch (error) {
      debugPrint(error.toString());
      emit(SocialappSendEmailerror());
    }
  }

  int currentindex = 0;

  List<Widget> screens = [
    Feedsscreen(),
    const NotficationsScrenn(),
    const MenuScreen(),
  ];

  List<Text> titles = [
    const Text(
      'Feeds',
      style: TextStyle(color: AppColors.blue, fontSize: 23),
    ),
    const Text(
      'Notifications',
      style: TextStyle(fontSize: 23),
    ),
    const Text(
      '',
      style: TextStyle(fontSize: 23),
    ),
  ];
  void changeindex(int index) {
    emit(SocialappInitial());
    currentindex = index;
    emit(SocialChangeBootmSheet());
  }

  File? profileimage;
  var picker = ImagePicker();

  Future<void> getprofileimage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      profileimage = File(pickedfile.path);
      emit(Socialappimageprofilepickerdone());
    } else {
      debugPrint('no image selectd ');
      emit(Socialappimageprofilepickererror());
    }
  }

  File? coverimage;

  //var coverpicker = ImagePicker();
  Future<void> getcpverimage() async {
    final pickcoverfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickcoverfile != null) {
      coverimage = File(pickcoverfile.path);
      emit(Socialappimagecoverepickerdone());
    } else {
      debugPrint('no image selectd ');
      emit(Socialappimagecoverepickererror());
    }
  }

  Future<void> uploadcoverimage({
    required String name,
    required String phone,
    required String bio,
    required String email,
  }) async {
    emit(SocialCubitUploadUserLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                updatauserdatat(
                    cover: value,
                    name: name,
                    phone: phone,
                    email: email,
                    bio: bio);
              }).catchError((error) {
                emit(SocialCubitUploadCoverimageError());
                debugPrint(error.toString());
              })
            });
  }

  Future<void> updatauserdatat({
    // required
    String? phone,
    // required
    String? name,
    //required
    String? bio,
    // required
    String? email,
    String? cover,
    String? image,
  }) async {
    emit(SocialCubitUploadUserLoading());
    FirebaseFirestore.instance.collection('users').doc(uidforall).update({
      'phone': phone == '' || phone == null ? usermodel!.phone : phone,
      'name': name == '' || name == null ? usermodel!.name : name,
      'bio': bio == '' || bio == null ? usermodel!.bio : bio,
      'uid': uidforall,
      'isEmailferivied': FirebaseAuth.instance.currentUser?.emailVerified,
      'email': email == '' || email == null ? usermodel!.email : email,
      'cover': cover ?? usermodel?.cover,
      'image': image ?? usermodel?.image,
      'token': token
    }).then((value) {
      if (name == '' || name == null) {
        emit(SocialCubitUploadUserScuflly());
      } else {
        updateallusername(name);
      }
    }).catchError((error) {
      emit(SocialCubitUploadUserError());
      debugPrint(error.toString());
    });
  }

  Future<void> uploadbothimage({
    required String name,
    required String phone,
    required String bio,
    required String email,
  }) async {
    emit(SocialCubitUploadUserLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                //  emit(SocialCubitUploadCoverimageScsufly());

                updatauserdatat(
                    name: name,
                    phone: phone,
                    bio: bio,
                    email: email,
                    cover: value);
              }).catchError((error) {
                emit(SocialCubitUploadCoverimageError());
                debugPrint(error.toString());
              })
            })
        .catchError((error) {
      emit(SocialCubitUploadCoverimageError());
      debugPrint(error.toString());
    });
    FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: uidforall)
        .snapshots()
        .listen((event) {
      userimag = [];
      for (var elemnt in event.docs) {
        userimag.add(elemnt.id);
      }
    });
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value1) {
                for (int i = 0; i < userimag.length; i++) {
                  FirebaseFirestore.instance
                      .collection('posts')
                      .doc(userimag[i])
                      .update({'image': value1}).then((value) {
                    updatauserdatat(
                        image: value1,
                        bio: bio,
                        email: email,
                        name: name,
                        phone: phone);
                    emit(UpdateUserImageAllDone());
                  }).catchError((e) {
                    emit(UpdateUserImageAllError());
                    debugPrint(e.toString());
                  });
                }
              }).catchError((e) {
                emit(UpdateUserImageAllError());
                debugPrint(e.toString());
              })
            })
        .catchError((e) {
      emit(UpdateUserImageAllError());
      debugPrint(e.toString());
    });
  }

  File? postgaleryimage;

  //var coverpicker = ImagePicker();
  Future<void> pickpostimage() async {
    final pickpostfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickpostfile != null) {
      postgaleryimage = File(pickpostfile.path);
      emit(Socialappimagepostepickerdone());
    } else {
      debugPrint('no image selectd ');
      emit(Socialappimagepostepickererror());
    }
  }

  void ceratposts({
    required String text,
    String? postimage,
  }) {
    emit(SocialCeratPostLoding());
    String notfiidh = const Uuid().v1();
    GetPosts postsmodel = GetPosts(
        datatime: DateTime.now(),
        image: usermodel!.image,
        name: usermodel!.name,
        uid: usermodel!.uid,
        postimage: postimage ?? '',
        text: text,
        commentint: 0,
        token: token,
        postid: notfiidh);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(notfiidh)
        .set(postsmodel.tomap())
        .then((value) {
      emit(SocialCeratPostScsfully());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SocialCeratPostError());
    });
  }

  void uploadpostimage({
    required String text,
    int? hight,
    int? width,
  }) {
    emit(SocialCeratPostLoding());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postgaleryimage!.path).pathSegments.last}')
        .putFile(postgaleryimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value)  {
               
                ceratposts(
                    text: text,
                    postimage: value,
                   
                    );
              }).catchError((error) {
                emit(SocialCeratPostError());
                debugPrint(error.toString());
              })
            })
        .catchError((error) {
      emit(SocialCeratPostError());
      debugPrint(error.toString());
    });
  }

  File? postgcameraimage;

  //var coverpicker = ImagePicker();
  Future<void> postgcamerimage() async {
    final pickpostfile = await picker.pickImage(source: ImageSource.camera);
    if (pickpostfile != null) {
      postgcameraimage = File(pickpostfile.path);

      emit(Socialcameraimagepostepickerdone());
    } else {
      debugPrint('no image selectd ');
      emit(Socialcameraimagepostepickererror());
    }
  }

  bool ispostloading = false;

  void uploadpostcamerimage({
    required String text,
  }) {
    emit(SocialCeratPostLoding());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postgcameraimage!.path).pathSegments.last}')
        .putFile(postgcameraimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                ceratposts(text: text, postimage: value);
              }).catchError((error) {
                emit(SocialCeratPostError());
                debugPrint(error.toString());
              })
            })
        .catchError((error) {
      emit(SocialCeratPostError());
      debugPrint(error.toString());
    });
  }

  void clearpostphoto() {
    postgaleryimage = null;
    postgcameraimage = null;
    commentimage = null;
    coverimage = null;
    pickpostimageu = null;
    pickstoryimage = null;
    profileimage = null;

    emit(SocialClearpostimage());
  }

  void clearupdatepostphoto() {
    pickpostimageu = null;

    emit(ClearPostUpdatePhoto());
  }

  void clearcommentimage() {
    commentimage = null;
    emit(SocialClearcommentimage());
  }

  List<String> friendscount = [];
  List<GetPosts> post = [];
  List<String> posid = [];
  List<String> commentid = [];
  List<String> mypostid = [];

  Future<void> getposts({String? uid1}) async {
    if (uidforall != null || uid1 != null) {
      emit(SocialappGetPostsLoading());

      try {
        FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datatime', descending: true)
            .snapshots()
            .listen((event) {
          posid = [];
          post = [];

          for (var element in event.docs) {
            posid.add(element.id);
            post.add(GetPosts.fromjason(element.data()));
            emit(SocialappGetPostsScsues());
          }
        });
      } catch (e) {
        emit(SocialappGetPostsError(e.toString()));
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  Future<void> editComment(
      String postidc, String commentid, String text) async {
    emit(EditCommentLoading());
    try {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postidc)
          .collection('comments')
          .doc(commentid)
          .update({'text': text});

      emit(EditCommentDone());
    } catch (e) {
      emit(EditCommentError());
      debugPrint(e.toString());
    }
  }

  Future<void> hidecomment(
      {required String postId, required String commentId}) async {
    emit(HideCommentLoading());
    try {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .update({'show': true});
      emit(HideCommentDone());
    } catch (e) {
      emit(HideCommentError());
      debugPrint(e.toString());
    }
  }

  Future<void> likepost(
    String postid,
    List likes,
  ) async {
    emit(SocialappGetLikesLoading());

    try {
      if (likes.contains(uidforall)) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postid)
            .update({
          'likes': FieldValue.arrayRemove([uidforall]),
        }); /*.then((value) {
         
             });
             */
        emit(SocialappGetLikesScsues());
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postid)
            .update({
          'likes': FieldValue.arrayUnion([uidforall]),
        });
        emit(SocialTest());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  File? commentimage;

  //var coverpicker = ImagePicker();
  Future<void> commentpickimage() async {
    final pickcommentfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickcommentfile != null) {
      commentimage = File(pickcommentfile.path);
      emit(Socialcameraimagecommentepickerdone());
    } else {
      debugPrint('no image selectd ');
      emit(Socialcameraimagecommentepickererror());
    }
  }

  List<Comments> comments = [];

  Future<void> postcomment({
    required String postid,
    required String tokenfcm,
    String? commentimage,
    String? text,
  }) async {
    emit(SocialappGetComentLoading());
    if (text != '' || commentimage != null) {
      String commentid = const Uuid().v1();

      Comments commentmodel = Comments(
          commentid: commentid,
          commentimage: commentimage ?? '',
          datatime: DateTime.now(),
          text: text,
          token: token,
          uid: usermodel!.uid,
          name: usermodel!.name,
          image: usermodel!.image);

      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .collection('comments')
          .doc(commentid)
          .set(commentmodel.tomap())
          .then((value) async {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('posts')
            .doc(postid)
            .get();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postid)
            .update({
          'commentint': (doc.data() as dynamic)['commentint'] + (1)
        }).then((value) {
          sendfcm(
              token: tokenfcm,
              title: 'socialapp',
              body: '${usermodel!.name} commentd in your post');
          emit(SocialappGetComentScsues());
        });
      }).catchError((error) {
        emit(SocialappGetComentError());
        debugPrint(error.toString());
      });
    } else {
      if (kDebugMode) {
        print('No Send');
      }
    }
  }

  bool iscommentloading = false;

  void uploadcommentcamerimage({
    required String text,
    required String token,
    required String postid,
  }) {
    emit(SocialCeratCommentLoding());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('comment/${Uri.file(commentimage!.path).pathSegments.last}')
        .putFile(commentimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                postcomment(
                    postid: postid,
                    text: text,
                    commentimage: value,
                    tokenfcm: token);
              }).catchError((error) {
                emit(SocialCeratCommentError());
                debugPrint(error.toString());
              })
            })
        .catchError((error) {
      emit(SocialCeratCommentError());
      debugPrint(error.toString());
    });
  }

  Future<void> likecomment({
    required String postid,
    required List comments,
    required String commentid,
    required String tokenfcm,
  }) async {
    emit(Socialsendcommentliksload());
    var e = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('comments')
        .doc(commentid)
        .get();
    if (e.exists) {
      try {
        if (comments.contains(uidforall)) {
          FirebaseFirestore.instance
              .collection('posts')
              .doc(postid)
              .collection('comments')
              .doc(commentid)
              .update({
            'comments': FieldValue.arrayRemove([uidforall]),
          });
          emit(Socialsendcommentliksdone1());
        } else {
          FirebaseFirestore.instance
              .collection('posts')
              .doc(postid)
              .collection('comments')
              .doc(commentid)
              .update({
            'comments': FieldValue.arrayUnion([uidforall]),
          });

          sendfcm(
              token: tokenfcm,
              title: 'socialapp',
              body: '${usermodel!.name} like your comment');
          emit(Socialsendcommentliksdone());
        }
      } catch (e) {
        if (kDebugMode) {
          emit(Socialsendcommentlikserror());
          print(e.toString());
        }
      }
    }
  }

  Future<void> saveImagetoGallery(String image) async {
    try {
      await GallerySaver.saveImage(image,
          albumName: 'Bigconnect', toDcim: true);

      emit(SaveImageToGallerySuccessfully());
    } catch (e) {
      emit(SaveImageToGalleryError());
    }
  }

  Future<void> deletpost(String postid, context) async {
    emit(DeletPostLoading());
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postid).delete();

      emit(DeletPostDone());
    } catch (e) {
      emit(DeletPostError());
    }
  }

  Future<void> hidepost(String postid, context) async {
    emit(HidePostLoadnig());

    try {
      await FirebaseFirestore.instance.collection('posts').doc(postid).update({
        'show': true,
      });
      emit(HidePostDone());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        emit(HidePostError());
      }
      // ignore: unused_local_variable

    }
  }

  Future<void> deletComment(String postid, String commenid) async {
    try {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .collection('comments')
          .doc(commenid)
          .delete();

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .get();
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postid)
          .update({'commentint': (doc.data() as dynamic)['commentint'] - (1)});

      emit(DeletCommentDone());
    } catch (e) {
      emit(DeletCommentError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

//
  QuerySnapshot<Map<String, dynamic>>? snap;

  bool showuser = false;
  bool iserror = false;
  Future<void> getsearch(String name) async {
    emit(SearchLoading());
    var e = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: name)
        .get();
    if (e.docs.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: name)
          .get()
          .then((value) {
        snap = value;
        showuser = true;
        iserror = false;
        emit(SearchDone());
      }).catchError((error) {
        emit(Searcherror());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      iserror = true;
      emit(Cearcherror());
    }
  }

  changeuser() {
    showuser = false;
    emit(ChangeUser());
  }

  Future<void> sendfriendrquest({
    required String token,
    required String friendid,
    // required String body,
    //required String title,
    //required String image,
  }) async {
    emit(AddFriendLoading());
    var e = await FirebaseFirestore.instance
        .collection('notifications')
        .where('check', isEqualTo: '$uidforall send frend request to $friendid')
        .get();
    try {
      String notfiid = const Uuid().v1();
      Notifications notimodel = Notifications(
          datatime: DateTime.now(),
          frienduid: friendid,
          name: usermodel!.name,
          image: usermodel!.image,
          notfiid: notfiid,
          uid: uidforall,
          bio: usermodel!.bio,
          token: token,
          check: '$uidforall send frend request to $friendid');

      if (e.docs.isEmpty) {
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(notfiid)
            .set(notimodel.tomap());
        FirebaseFirestore.instance.collection('users').doc(friendid).update({
          'friendsRquest': FieldValue.arrayUnion([uidforall]),
        });
      } else {
        FirebaseFirestore.instance.collection('users').doc(friendid).update({
          'friendsRquest': FieldValue.arrayUnion([uidforall]),
        });
      }
      sendfcm(
        token: token,
        title: 'Socialapp',
        body: '${usermodel!.name} Send to you friend request',
      );

      emit(AddFriendCompelet());
    } catch (e) {
      emit(AddFriendError());
      debugPrint(e.toString());
    }
  }

  List<Notifications> notifications = [];
  List<String> notifid = [];

  List<String> allnotifid = [];

  Future<void> getnotifications({String? uid1}) async {
    if (uidforall != null || uid1 != null) {
      emit(SocialappGetNotiLoading());

      try {
        FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('datatime', descending: true)
            .snapshots()
            .listen((event) {
          notifid = [];
          notifications = [];
          allnotifid = [];
          for (var element in event.docs) {
            allnotifid.add(element.id);
            if (element.data()['frienduid'] == uidforall ||
                element.data()['frienduid'] == uid1) {
              notifid.add(element.id);
              notifications.add(Notifications.fromjason(element.data()));

              emit(SocialappGetNotiScsues());
            }
          }
        });
      } catch (e) {
        emit(SocialappGetNotiError());
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  Future<void> deletnotifications(
      {required String friendidfordelet, required String otheruid}) async {
    emit(DeletFristNotificationsLoading());
    try {
      FirebaseFirestore.instance
          .collection('notifications')
          .doc(friendidfordelet)
          .delete();

      FirebaseFirestore.instance.collection('users').doc(otheruid).update({
        'friendsRquest': FieldValue.arrayRemove([uidforall]),
      });
      FirebaseFirestore.instance.collection('users').doc(uidforall).update({
        'friendsRquest': FieldValue.arrayRemove([otheruid]),
      });
      emit(DeletFristNotificationsDone());
    } catch (e) {
      emit(DeletFristNotificationsError());
    }
  }

  Future<void> cancelfriend({
    required String otheruid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(otheruid).update({
        'friendsRquest': FieldValue.arrayRemove([uidforall]),
      });
      emit(CncelFriendDone());
    } catch (e) {
      emit(CncelFriendError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> deletnotifications2({
    required String friendid,
    required String otheruidforall,
    required String image,
    required String name,
    required String friendidfordelet,
    required String token,
    required String bio1,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection('notifications')
          .doc(friendidfordelet)
          .delete();
      FirebaseFirestore.instance.collection('users').doc(friendid).update({
        'friendsRquest': FieldValue.arrayRemove([uidforall]),
      });

      accpetfriend2(
          otheruidforall: otheruidforall,
          image: image,
          name: name,
          bio1: bio1,
          token: token);
      //emit(DeletFristNotifications2Done());
    } catch (e) {
      emit(DeletFristNotifications2Error());
    }
  }

  Future<void> accpetfriend({
    required String frienduid,
    //required String notifiid,
    required String notifiid,
    required String image,
    required String name,
    required String token,
    required String bio1,
  }) async {
    emit(AcceptFriendLoading());

    Friends model = Friends(
        datatime: DateTime.now(),
        friendsId: frienduid,
        image: usermodel!.image,
        name: usermodel!.name,
        uid: uidforall,
        bio: usermodel!.bio);
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(frienduid)
          .collection('friends')
          .doc(uidforall)
          .set(model.tomap());
      //?updat users make List of friends
      FirebaseFirestore.instance.collection('users').doc(frienduid).update({
        'friends': FieldValue.arrayUnion([uidforall]),
      });
      //?Update friends make List of friends
      FirebaseFirestore.instance
          .collection('users')
          .doc(frienduid)
          .collection('friends')
          .doc(uidforall)
          .update({
        'friends': FieldValue.arrayUnion([uidforall])
      });

      deletnotifications2(
          friendid: frienduid,
          image: image,
          name: name,
          bio1: bio1,
          otheruidforall: frienduid,
          friendidfordelet: notifiid,
          token: token);
      // emit(AcceptFriendDone());
    } catch (e) {
      emit(AcceptFriendError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> deletfriend(String friendId) async {
    //  emit(DeletFriendLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .collection('friends')
          .doc(uidforall)
          .delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .update({
        'friends': FieldValue.arrayRemove([uidforall])
      });

      deletfriend2(friendId);
      emit(DeletFriendDone());
    } catch (e) {
      emit(DeletFriendError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> accpetfriend2({
    required String otheruidforall,
    required String image,
    required String name,
    required String token,
    required String bio1,
  }) async {
    Friends model = Friends(
      datatime: DateTime.now(),
      friendsId: otheruidforall,
      image: image,
      name: name,
      uid: otheruidforall,
      bio: bio1,
    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uidforall)
          .collection('friends')
          .doc(otheruidforall)
          .set(model.tomap());
      //?updat users make List of friends
      FirebaseFirestore.instance.collection('users').doc(uidforall).update({
        'friends': FieldValue.arrayUnion([otheruidforall]),
      });
      //?Update friends make List of friends
      FirebaseFirestore.instance
          .collection('users')
          .doc(uidforall)
          .collection('friends')
          .doc(otheruidforall)
          .update({
        'friends': FieldValue.arrayUnion([otheruidforall])
      });
      FirebaseFirestore.instance.collection('users').doc(uidforall).update({
        'friendsRquest': FieldValue.arrayRemove([otheruidforall]),
      });
      sendfcm(
          token: token,
          title: 'socialapp',
          body: '${usermodel!.name} accept your friend request');

      emit(AcceptFriendDone2());
    } catch (e) {
      emit(AcceptFriendError2());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> deletfriend2(String friendId) async {
    emit(DeletFriendLoading2());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidforall)
          .collection('friends')
          .doc(friendId)
          .delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidforall)
          .update({
        'friends': FieldValue.arrayRemove([friendId])
      });
      FirebaseFirestore.instance.collection('users').doc(friendId).update({
        'friendsRquest': FieldValue.arrayRemove([uidforall]),
      });

      emit(DeletFriendDone2());
    } catch (e) {
      emit(DeletFriendError2());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> updatetoken(context, {String? uid1}) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uidforall ?? uid1)
          .update({'token': token});
      emit(UpdateTokenDone());
    } catch (error) {
      debugPrint(error.toString());
      emit(UpdateTokenError());
    }
  }

  Future<void> gettoken({String? uid1}) async {
    if (uidforall != null || uid1 != null) {
      emit(GetUserTokenLoading());
      FirebaseMessaging massaging = FirebaseMessaging.instance;
      NotificationSettings settings = await massaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );
      massaging.getToken().then((value) {
        // if (kDebugMode) {
        //   print('token is $value ');
        // }
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          debugPrint('user ganret peramison');
        } else if (settings.authorizationStatus ==
            AuthorizationStatus.provisional) {
          debugPrint('user ganret provisional');
        } else {
          debugPrint('user denied');
        }
        CacheHelper.savedata(key: 'token', value: value);
        localnotifications();
        emit(GetUserTokenDone());
      }).catchError((error) {
        emit(GetUserTokenError());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> localnotifications() async {
    var andriodinailze =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationsettingdSettings =
        InitializationSettings(android: andriodinailze);
    flutterLocalNotificationsPlugin.initialize(initializationsettingdSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationspecfic =
          AndroidNotificationDetails('2', '2',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails platfromchanelspecifics =
          NotificationDetails(android: androidNotificationspecfic);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platfromchanelspecifics,
          payload: message.data['body']);
    });
  }

  Future<void> sendfcm({
    required String token,
    required String title,
    required String body,
    //required String image,
  }) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Authorization':
                'key=AAAA8erSCIo:APA91bExzeVvm5nFVM19rA6lWHPfvsVy1i6_8mRmlGj1QTb5XYc1ah__c9oUOFvJCDsOd9i5PWUlZXG796WAT5I4q-_slRitx0XKMTinjWRdXfR6ZSiaDoPo3nC9hrD_2uLGIOi37n7i',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': 'Bigconecct',
            },
            "notification": <String, dynamic>{
              "title": 'Bigconecct',
              "body": body,
              "android_channel_id": "2"
            },
            "to": token
          }));
    } catch (e) {
      emit(SendFcmError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  File? pickstoryimage;

  Future<void> storyimage(context) async {
    try {
      final pickstory1image =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickstory1image != null) {
        pickstoryimage = File(pickstory1image.path);
        PaletteGenerator paletteGenerator =
            await PaletteGenerator.fromImageProvider(FileImage(pickstoryimage!),
                maximumColorCount: 20, size: const Size(200, 200));
        navigtonto(
            context,
            CeratStory(
              paletteGenerator: paletteGenerator,
            ));
      } else {
        debugPrint('no image selectd ');
      }
      emit(StoryPickImageDone());
    } catch (e) {
      emit(StoryPickImageError());
      debugPrint(e.toString());
    }
  }

  var ref = firebase_storage.FirebaseStorage.instance.ref();
  Future<void> uploadStoryimage({
    required String capiton,
  }) async {
    emit(UploadStoryImageLoading());
    ref
        .child('story/${Uri.file(pickstoryimage!.path).pathSegments.last}')
        .putFile(pickstoryimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadStory(image: value, capiton: capiton);
        emit(UploadStoryImageDone());
      }).catchError((e) {
        emit(UploadStoryImageError());
        debugPrint(e.toString());
      });
    }).catchError((e) {
      emit(UploadStoryImageError());
      debugPrint(e.toString());
    });
  }

  //List<String> imageurl = [];

  Future<void> uploadStory({
    required String image,
    required String capiton,
  }) async {
    /// emit(UploadStoryImageLoading());
    var e = await FirebaseFirestore.instance
        .collection('stories')
        .where('uid', isEqualTo: uidforall)
        .get();

    if (e.docs.isEmpty) {
      Story model = Story(
          storyimage: [image],
          datatime: DateTime.now(),
          name: usermodel?.name,
          token: token,
          uid: uidforall,
          userimage: usermodel?.image,
          capiton: [capiton],
          times: [DateTime.now()]);
      FirebaseFirestore.instance
          .collection('stories')
          .doc(uidforall)
          .set(model.tomap())
          .then((value) {
        // emit(UploadStoryImageDone());
      }).catchError((e) {
        emit(UploadStoryImageError());
        debugPrint(e.toString());
      });
    } else {
      FirebaseFirestore.instance.collection('stories').doc(uidforall).update({
        'storyimage': FieldValue.arrayUnion([image]),
        'times': FieldValue.arrayUnion([DateTime.now()]),
        // if (capiton != '')
        'capiton': FieldValue.arrayUnion([capiton]),
      }).then((value) {
//        emit(UploadStoryImageDone());
      }).catchError((e) {
        emit(UploadStoryImageError());
        debugPrint(e.toString());
      });
    }
  }

  void deletstoryimage() {
    pickstoryimage = null;
    emit(DeletStoryImage());
  }

  List<Story> stortlist = [];
  List<String> storyid = [];
  Story? storymodel;
  Future<void> getstoryes({String? uid1}) async {
    if (uidforall != null || uid1 != null) {
      emit(GetStoryLoading());
      try {
        FirebaseFirestore.instance
            .collection('stories')
            .orderBy('datatime', descending: true)
            .snapshots()
            .listen((event) {
          stortlist = [];
          storyid = [];
          for (var element in event.docs) {
            if (usermodel!.friends.contains(element.data()['uid']) ||
                element.data()['uid'] == 'big') {
              storyid.add(element.id);
              stortlist.add(Story.fromjason(element.data()));
              storymodel = Story.fromjason(element.data());

              emit(GetStoryDone());
            }
          }
        });
      } catch (e) {
        emit(GetStoryError());
        debugPrint(e.toString());
      }
    }
  }

  List<String> userimag = [];
  Future<void> updateImageAllUser({
    String? name,
    String? phone,
    String? bio,
    String? email,
  }) async {
    FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: uidforall)
        .snapshots()
        .listen((event) {
      userimag = [];
      for (var elemnt in event.docs) {
        userimag.add(elemnt.id);
      }
    });
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value1) {
                for (int i = 0; i < userimag.length; i++) {
                  FirebaseFirestore.instance
                      .collection('posts')
                      .doc(userimag[i])
                      .update({'image': value1}).then((value) {
                    updatauserdatat(
                        image: value1,
                        bio: bio,
                        email: email,
                        name: name,
                        phone: phone);
                    emit(UpdateUserImageAllDone());
                  }).catchError((e) {
                    emit(UpdateUserImageAllError());
                    debugPrint(e.toString());
                  });
                }
              }).catchError((e) {
                emit(UpdateUserImageAllError());
                debugPrint(e.toString());
              })
            })
        .catchError((e) {
      emit(UpdateUserImageAllError());
      debugPrint(e.toString());
    });
  }

  List<String> allnamepost = [];
  Future<void> updateallusername(String name) async {
    FirebaseFirestore.instance
        .collection('posts')
        .where(
          'uid',
          isEqualTo: uidforall,
        )
        .snapshots()
        .listen((event) {
      allnamepost = [];
      for (var elemnt in event.docs) {
        allnamepost.add(elemnt.id);
      }
    });
    for (int i = 0; i < allnamepost.length; i++) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(allnamepost[i])
          .update({'name': name}).then((value) {
        emit(UpdateUserNameAllDone());
      }).catchError((e) {
        emit(UpdateUserNameAllError());
        debugPrint(e.toString());
      });
    }
  }

  File? pickpostimageu;

  Future<void> pickimagepost() async {
    try {
      final pickedfile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        pickpostimageu = File(pickedfile.path);
        emit(PickPostImageDone());
      }
    } catch (e) {
      emit(PickPostImageError());
      debugPrint(e.toString());
    }
  }

  Future<void> editpost({
    String? image,
    String? text,
    required String uid,
  }) async {
    emit(EditPostLoading());
    try {
      FirebaseFirestore.instance.collection('posts').doc(uid).update({
        if (image != null) 'postimage': image,
        if (text != '') 'text': text,
      });
      emit(EditPostDone());
    } catch (e) {
      emit(EditPostError());
      debugPrint(e.toString());
    }
  }

  void onchangestate() {
    emit(OnChangeState());
  }

  Future<void> uploadimageforpostedit(
      {String? text, required String uid}) async {
    try {
      var ref = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('editpost/${Uri.file(pickpostimageu!.path).pathSegments.last}')
          .putFile(pickpostimageu!);
      var url = await ref.ref.getDownloadURL();
      editpost(uid: uid, image: url, text: text);
    } catch (e) {
      emit(EditPostImageError());
      debugPrint(e.toString());
    }
  }

  bool? isdark = false;
  void changedarkmood({bool? fromshared}) {
    emit(SocialappInitial());
    if (fromshared != null) {
      isdark = fromshared;
      emit(ChangeDarkmood());
    } else {
      isdark = !isdark!;
      CacheHelper.savedata(key: 'darkmode', value: isdark!).then((value) {
        emit(ChangeDarkmood());
      });
    }
  }

  Future<void> deletMuAccount(context) async {
    emit(DeletAccountLoading());
    try {
      FirebaseAuth.instance.currentUser!.delete();
      FirebaseFirestore.instance.collection('users').doc(uidforall).delete();
      CacheHelper.removedatae(key: 'uid');
      navigtonandfinish(context, const Splach_View());
      clearpostphoto();
    } catch (e) {
      emit(DeletAccountError());
      debugPrint(e.toString());
    }
  }

  Future<void> updatepubilcrules({
    required String locaiton,
    required String education,
    required String socialsituation,
    required String uid,
  }) async {
    emit(EditPubilcRulesLoading());
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'locaiton': locaiton,
        'education': education,
        'socialsituation': socialsituation,
        'token': token,
      });
      if (profileimage != null) {
        updateImageAllUser();
      } else {
        emit(EditPubilcRulesDone());
      }
    } catch (e) {
      emit(EditPubilcRulesError());
      debugPrint(e.toString());
    }
  }
}
