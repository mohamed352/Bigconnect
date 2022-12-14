import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/data/models/reply.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/commentitem.dart';

Widget listReplays(
    {required String postId, required context, required String tokenpost,required AsyncSnapshot<dynamic> snapshot,}) {
  var cubit = SocialappCubit.get(context);
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(8),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      Replays model = cubit.replays[index];
      return  buildcommentitem(
        commentid: model.replayid,
        commentimage: model.commentimage,
        comments: model.replays,
        tokenpost: tokenpost,
        commentidforreplay: model.commentid,
        isreplay: true,
        commentname: model.commentname,
        context: context,
        datatime: model.datatime,
        index: index,
        postId: postId,
        show: model.show,
        text: model.text,
        tokenfcm: model.token,
        uid: model.uid,
      );
    },
    itemCount: cubit.replays.length,
  );
}
