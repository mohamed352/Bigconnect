import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/data/models/commentmodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/streamcomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

TextEditingController commenControler = TextEditingController();
Future<dynamic> addcommenttest(
    {required context,
    required String postId,
    required String tokenpost}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      var cubit = SocialappCubit.get(context);

      return BlocConsumer<SocialappCubit, SocialappState>(
        listener: (context, state) async {
          if (state is SocialappGetComentScsues) {
            await cubit.playLoadingAudioComment(context, commenControler);
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
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(postId)
                      .collection('comments')
                      .orderBy('datatime', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: LottieBuilder.asset(AppImageAssets.loading));
                    } else {
                      cubit.comments = [];
                      cubit.commentid = [];
                      // cubit.commentimage = null;
                      for (var element in snapshot.data!.docs) {
                        cubit.commentid.add(element.id);

                        cubit.comments.add(Comments.fromjason(element.data()));
                      }
                    }

                    return streamcomment(
                        context: context,
                        commenControler: commenControler,
                        postId: postId,
                        snapshot: snapshot,
                        tokenpost: tokenpost);
                  }));
        },
      );
    },
  );
}
