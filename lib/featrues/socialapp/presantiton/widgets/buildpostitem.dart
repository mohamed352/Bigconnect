

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/addcomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/feeds/modelsheetforpost.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/feeds/pepolereact.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/feeds/textfromfieldforpost.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/fromattime.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/likesanimation.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/previwimage.dart';

Widget buildpostitem(
  // GetPosts model,
  context,
  index, {
  required String? name,
  required String? postId,
  // ignore: prefer_typing_uninitialized_variables
  required final datatime,
  required String? text,
  required String? uid1,
  required String? image,
  required String? postimage,
  required List<dynamic> likes,
  required bool? show,
  required int commentint,
  //?post id or mypostid in cubit
  required List postid,
  required bool showpostfriend,
  required String tokenpost,
}) {
  var cubit1 = SocialappCubit.get(context);

  return Conditional.single(
    context: context,
    conditionBuilder: (context) => show != true && showpostfriend,
    widgetBuilder: (context) {
      return StreamBuilder<QuerySnapshot>(
          stream:
           FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: uid1)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: LottieBuilder.asset(AppImageAssets.loading));
            } else {
              var snap = snapshot.data!.docs[0].data() as Map<String, dynamic>;
              return Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              navigtonto(
                                  context,
                                  ProfileScreen(
                                    otheruid: uid1,
                                  ));
                            },
                            child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(snap['image']))),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigtonto(
                                          context,
                                          ProfileScreen(
                                            otheruid: uid1,
                                          ));
                                    },
                                    child: Text(
                                      snap['name'],
                                      style: const TextStyle(
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.blue,
                                    size: 15.0,
                                  ),
                                ],
                              ),
                              Text(
                                getTimeDifferenceFromNow(datatime.toDate()),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      height: 1.4,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            size: 16.0,
                          ),
                          onPressed: () {
                            modelSheetForPost(
                                context: context,
                                uid1: uid1,
                                image: image,
                                text: text,
                                name: name,
                                postId: postId,
                                postimage: postimage,
                                postid: postid,
                                index: index);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: double.infinity,
                      height: 2.0,
                      color: cubit1.isdark == false
                          ? Colors.grey.shade300
                          : Colors.grey.shade800,
                      margin:
                          EdgeInsets.symmetric(vertical: text == '' ? 7 : 0),
                    ),
                    if (text != '')
                      InkWell(
                        onLongPress: () async {
                          await Clipboard.setData(ClipboardData(text: text));
                          showSnackBar(
                            context: context,
                            text: 'Text copied to clipboard',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '$text',
                            style: const TextStyle(height: 1.3),
                          ),
                        ),
                      ),
                    if (postimage == '')
                      const SizedBox(
                        height: 4,
                      ),
                    if (postimage == '')
                      const SizedBox(
                        height: 40,
                      ),
                    if (postimage != '')
                      GestureDetector(
                          onTap: () async {
                            PaletteGenerator paletteGenerator =
                                await PaletteGenerator.fromImageProvider(
                                    NetworkImage(postimage!),
                                    maximumColorCount: 20,
                                    size: const Size(200, 200));
                            pageView(
                                image: postimage,
                                context: context,
                                paletteGenerator: paletteGenerator);
                          },
                          //?hight = 960 width = 853

                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.63,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('$postimage'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                              ),
                              child: Row(
                                children: [
                                  LikesAnimations(
                                    isanimations: likes.contains(uidforall),
                                    smalllike: true,
                                    child: Icon(Icons.favorite,
                                        color: likes.contains(uidforall)
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    '${likes.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(SlideRight(
                                  page: PepoleReact(
                                likes: likes,
                              )));
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    size: 16,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 1.0,
                                  ),
                                  Text(
                                    ' $commentint',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              addcommenttest(
                                  context: context,
                                  postId: postid[index],
                                  tokenpost: tokenpost);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: AppColors.grayshade,
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.0,
                                  backgroundImage: NetworkImage(
                                      '${cubit1.usermodel?.image}'),
                                ),
                                textFromFieldForPost(
                                    context: context,
                                    tokenpost: tokenpost,
                                    postid: postid,
                                    index: index)
                              ],
                            ),
                          ),
                          LikeButton(
                            likeCount: likes.length,
                            isLiked:
                                likes.isNotEmpty && likes.contains(uidforall)
                                    ? true
                                    : false,
                            onTap: (isliked) async {
                              SocialappCubit.get(context)
                                  .likepost(postid[index], likes);
                              return !isliked;
                            },
                            likeCountAnimationType: LikeCountAnimationType.all,
                            likeBuilder: (isliked) {
                              return Icon(
                                Icons.favorite,
                                size: 25,
                                color: isliked ? Colors.red : Colors.grey,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          });
    },
    fallbackBuilder: (context) => Container(),
  );
}
