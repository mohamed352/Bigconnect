import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/data/models/reply.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/Replay/listreplays.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/Replay/replaysend.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/streamcomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

TextEditingController replayControler = TextEditingController();
Future<dynamic> addReplaytest(
    {required context,
    required String postId,
    required String commentid,
    required String commentname,
    required FocusNode focusNode,
    required AsyncSnapshot<dynamic> snapshot,
    required String tokenpost}) async {
  // replayControler.text = '@$commentname';
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      var cubit = SocialappCubit.get(context);

      return BlocConsumer<SocialappCubit, SocialappState>(
        listener: (context, state) async {
          if (state is SocialappGetComentScsues) {
            await cubit.playLoadingAudioComment(context, replayControler);
          }
          if (state is Socialsendcommentliksdone) {
            await cubit.playLikeSound();
          }
          if (state is DeletCommentDone) {
            showSnackBar(
              context: context,
              text: 'Delet comment sucsfully',
            );
          }
          if (state is HideCommentDone) {
            showSnackBar(
              context: context,
              text: 'Hide comment sucsfully',
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              body:
              /*
               streamcomment(
                  context: context,
                  appBarTitle: 'Replay  to  $commentname',
                  comments: cubit.replays,
                  commenControler: replayControler,
                  isreplay: true,
                  postId: postId,

                  snapshot: snapshot,
                  commentsend: replaySend(
                    context: context,
                    focusNode: focusNode,
                    commentname: commentname,
                    commentid: commentid,
                    postId: postId,
                    token: tokenpost,
                    replayControler: replayControler,
                  ),
                  tokenpost: tokenpost,
                  listview: listReplays(
                      postId: postId, context: context,
                      snapshot: snapshot, tokenpost: tokenpost)));
*/
          
               StreamBuilder<QuerySnapshot>(
                  stream:
                   FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .collection('comments')
                      .doc(commentid)
                      .collection('Replaies')
                      .orderBy('datatime', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: LottieBuilder.asset(AppImageAssets.loading));
                    } else {
                      cubit.replays = [];
                      cubit.replaysid = [];

                      for (var element in snapshot.data!.docs) {
                        cubit.replaysid.add(element.id);

                        cubit.replays.add(Replays.fromjason(element.data()));
                      }
                    }

                    return
                     streamcomment(
                      context: context,
                      appBarTitle: 'Replay  to  $commentname',
                      comments: cubit.replays,
                      commenControler: replayControler,
                      isreplay: true,
                      postId: postId,
                      snapshot: snapshot,
                      commentsend: replaySend(
                        context: context,
                        focusNode: focusNode,
                        commentname: commentname,
                        commentid: commentid,
                        postId: postId,
                        token: tokenpost,
                        replayControler: replayControler,
                      ),
                      tokenpost: tokenpost,
                      listview: listReplays(
                          postId: postId,
                          context: context,
                          snapshot: snapshot,
                          tokenpost: tokenpost),
                    );
                  }));
        
        },
      );
    },
  );
}
