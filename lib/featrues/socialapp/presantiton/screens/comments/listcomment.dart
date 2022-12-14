import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/data/models/commentmodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/commentitem.dart';
Widget listcomment({required String postId, required context,required String tokenpost}) {
  var cubit = SocialappCubit.get(context);
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(8),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      Comments model = cubit.comments[index];
      return buildcommentitem(
        commentid: model.commentid,
        commentimage: model.commentimage,
        comments: model.comments, 
        tokenpost: tokenpost,
        
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
    itemCount: cubit.comments.length,
  );
}
