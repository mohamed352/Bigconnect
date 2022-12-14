import 'package:flutter/material.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/editcomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Future<dynamic> modelCommentSheet({
  required context,
  required int index,
  required String? postId,
  required bool? show,
  required String? uid,
  bool? isreplay,
  String? commentidforreplay,
  required String? text,
  required String image,
  required String? commentimage,
  required dynamic datatime,
  required List? comments,
  required String? commentid,
  required String? tokenfcm,
}) async {
  var cubit = SocialappCubit.get(context);
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => SizedBox(
      height: uidforall == uid
          ? MediaQuery.of(context).size.height * 0.36
          : MediaQuery.of(context).size.height * 0.21,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: comments!.contains(uidforall)
                        ? Colors.blue
                        : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          isreplay == true
                              ? cubit.likereplay(
                                  tokenfcm: tokenfcm!,
                                  postid: postId!,
                                  replayid: '$commentid',
                                  comments: comments,
                                  commentid: '$commentidforreplay')
                              : cubit.likecomment(
                                  tokenfcm: tokenfcm!,
                                  postid: postId!,
                                  comments: comments,
                                  commentid: cubit.commentid[index]);
                        },
                        icon: const Icon(
                          Icons.thumb_up_alt,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            if (uidforall == uid)
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
              ),
            if (uidforall == uid)
              InkWell(
                onTap: () {
                  isreplay == true
                      ? cubit.deletReplay(
                          postId!, commentidforreplay!, commentid!)
                      : cubit.deletComment(postId!, cubit.commentid[index]);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Delet Comment',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            if (uidforall == uid && isreplay != true)
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
              ),
            if (uidforall == uid && isreplay != true)
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  navigtonto(
                      context,
                      EditComment(
                        commentId: commentid!,
                        image: image,
                        postid: postId!,
                        text: text!,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'edit Comment',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
            ),
            InkWell(
              onTap: () {
                isreplay == true
                    ? cubit.hideReplay(
                        postId: postId!,
                        replayid: commentid!,
                        commentId: commentidforreplay!)
                    : cubit.hidecomment(
                        postId: postId!, commentId: cubit.commentid[index]);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.visibility_off,
                      size: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Hide Comment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => myAlertDiloag(context),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_rounded,
                      size: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Report Comment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
