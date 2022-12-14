import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/Replay/showreplayincomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/commentbar.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/previwimage.dart';

import 'modelsheetcomment.dart';

Widget buildcommentitem({
  required context,
  required int index,
  required String? postId,
  required bool? show,
  String? commentidforreplay,
  bool? isreplay,
  required String? uid,
  required String? text,
  String? commentname,
  required String? commentid,
  required String? tokenpost,
  required String? commentimage,
  required dynamic datatime,
  required List? comments,
  required String? tokenfcm,
}) {
  var cubit = SocialappCubit.get(context);

  return Conditional.single(
    context: context,
    conditionBuilder: (context) => show != true,
    widgetBuilder: (context) {
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: LottieBuilder.asset(AppImageAssets.loading));
            } else {
              var snap = snapshot.data!.data() as Map<String, dynamic>;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      navigtonto(
                          context,
                          ProfileScreen(
                            otheruid: uid,
                          ));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(snap['image']),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (text == '' || text == null)
                          InkWell(
                            onTap: () {
                              navigtonto(
                                  context,
                                  ProfileScreen(
                                    otheruid: uid,
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Text(
                                snap['name'],
                                style: const TextStyle(
                                    height: 1.4, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        if (text != '' && text != null)
                          GestureDetector(
                            onLongPress: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              modelCommentSheet(
                                commentid: commentid,
                                commentimage: commentimage,
                                comments: comments,
                                context: context,
                                isreplay: isreplay,
                                datatime: datatime,
                                image: snap['image'],
                                index: index,
                                postId: postId,
                                show: show,
                                text: text,
                                commentidforreplay: commentidforreplay,
                                tokenfcm: tokenfcm,
                                uid: uid,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: cubit.isdark == false
                                      ? AppColors.grayshade
                                      : Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigtonto(
                                          context,
                                          ProfileScreen(
                                            otheruid: uid,
                                          ));
                                    },
                                    child: Text(
                                      snap['name'],
                                      style: const TextStyle(
                                          height: 1,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  if (isreplay == true)
                                    Text(
                                      '$commentname',
                                      style: TextStyle(
                                          color: Colors.blue.shade400,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  LinkifyText(
                                    text,
                                    linkStyle: const TextStyle(
                                        height: 1.3, color: Colors.blue),
                                    linkTypes: const [
                                      LinkType.url,
                                      LinkType.hashTag,
                                      LinkType.email,
                                      LinkType.userTag
                                    ],
                                    onTap: (link) {},
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (commentimage != '')
                          GestureDetector(
                            onLongPress: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              modelCommentSheet(
                                commentid: commentid,
                                commentimage: commentimage,
                                comments: comments,
                                context: context,
                                datatime: datatime,
                                isreplay: isreplay,
                                image: snap['image'],
                                index: index,
                                postId: postId,
                                show: show,
                                commentidforreplay: commentidforreplay,
                                text: text,
                                tokenfcm: tokenfcm,
                                uid: uid,
                              );
                            },
                            onTap: () async {
                              PaletteGenerator paletteGenerator =
                                  await PaletteGenerator.fromImageProvider(
                                      NetworkImage(commentimage!),
                                      maximumColorCount: 20,
                                      size: const Size(200, 200));
                              pageView(
                                  context: context,
                                  image: commentimage,
                                  paletteGenerator: paletteGenerator);
                            },
                            child: AspectRatio(
                              aspectRatio: 3 / 2,
                              child: Image.network(
                                  alignment: AlignmentDirectional.topStart,
                                  isAntiAlias: true,
                                  fit: BoxFit.contain,
                                  matchTextDirection: true,
                                  commentimage!),
                            ),
                          ),
                        commentBar(
                          commentid: commentid,
                          commentimage: commentimage,
                          comments: comments,
                          context: context,
                          snapshot: snapshot,
                          datatime: datatime,
                          index: index,
                          name: snap['name'],
                          postId: postId,
                          show: show,
                          text: text,
                          tokenfcm: tokenfcm,
                          tokenpost: tokenpost,
                          uid: uid,
                          commentidforreplay: commentidforreplay,
                          commentname: commentname,
                          isreplay: isreplay,
                        ),
                        if (isreplay != true)
                          showreplay(
                            commentid: commentid!,
                            name: snap['name'],
                            context: context,
                            tokenpost: tokenpost,
                            postId: postId!,
                            uid: uid!,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }
          });
    },
    fallbackBuilder: (context) => Container(),
  );
}
