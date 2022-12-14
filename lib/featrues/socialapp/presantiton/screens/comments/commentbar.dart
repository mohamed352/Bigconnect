import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/Replay/addreplay.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/fromattime.dart';

Widget commentBar({
  required context,
  required int index,
  required String? postId,
  required bool? show,
  String? commentidforreplay,
  bool? isreplay,
  required String? uid,
  required String? text,
  String? commentname,
  required String? name,
  required AsyncSnapshot<dynamic> snapshot,
  required String? commentid,
  required String? tokenpost,
  required String? commentimage,
  required dynamic datatime,
  required List? comments,
  required String? tokenfcm,
}) {
  var cubit = SocialappCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTimeDifferenceFromNow(datatime.toDate(), true),
          style: Theme.of(context).textTheme.caption!.copyWith(height: 2.3),
        ),
        if (isreplay != true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LikeButton(
              isLiked: comments!.contains(uidforall),
              onTap: (isliked) async {
                cubit.likecomment(
                    tokenfcm: tokenfcm!,
                    postid: postId!,
                    comments: comments,
                    commentid: cubit.commentid[index]);
                return !isliked;
              },
              bubblesColor: const BubblesColor(
                  dotPrimaryColor: Colors.blueAccent,
                  dotSecondaryColor: Colors.blue),
              circleColor: const CircleColor(
                  start: Colors.lightBlue, end: Colors.lightBlueAccent),
              likeBuilder: (isliked) {
                return Icon(Icons.thumb_up_alt,
                    size: 25, color: isliked ? Colors.blue : Colors.grey);
              },
              likeCount: comments.length,
              countDecoration: (count, likeCount) {
                return Text(
                  '${comments.length}',
                  style:
                      Theme.of(context).textTheme.caption!.copyWith(height: 2),
                );
              },
            ),
          ),
        if (isreplay == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LikeButton(
              isLiked: comments!.contains(uidforall),
              onTap: (isliked) async {
                cubit.likereplay(
                    tokenfcm: tokenfcm!,
                    postid: postId!,
                    replayid: '$commentid',
                    comments: comments,
                    commentid: '$commentidforreplay');
                return !isliked;
              },
              likeBuilder: (isliked) {
                return Icon(
                  Icons.favorite,
                  size: 25,
                  color: isliked ? Colors.red : Colors.grey,
                );
              },
              likeCountAnimationType: LikeCountAnimationType.all,
              likeCount: comments.length,
              countDecoration: (count, likeCount) {
                return Text(
                  '${comments.length}',
                  style:
                      Theme.of(context).textTheme.caption!.copyWith(height: 2),
                );
              },
            ),
          ),
        if (isreplay != true)
          InkWell(
            onTap: () {
              FocusNode focusNode = FocusNode(canRequestFocus: true);

              addReplaytest(
                  context: context,
                  postId: postId!,
                  snapshot: snapshot,
                  focusNode: focusNode,
                  commentid: commentid!,
                  commentname: '$name',
                  tokenpost: tokenpost!);
            },
            child: Text('Replay',
                style:
                    Theme.of(context).textTheme.caption!.copyWith(height: 2.3)),
          ),
        
      ],
    ),
  );
}
