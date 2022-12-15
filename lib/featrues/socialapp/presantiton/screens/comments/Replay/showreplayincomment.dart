import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/data/models/reply.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/Replay/addreplay.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Widget showreplay({
  required String postId,
  required String commentid,
  required String name,
  required String? tokenpost,
  required String uid,
  required context,
}) {
  var cubit = SocialappCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentid)
            .collection('Replaies')
            .orderBy('datatime', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LottieBuilder.asset(AppImageAssets.loading));
          } else if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
            cubit.replays = [];
            cubit.replaysid = [];

            for (var element in snapshot.data!.docs) {
              cubit.replaysid.add(element.id);

              cubit.replays.add(Replays.fromjason(element.data()));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Replays model = cubit.replays[index];
                        return StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(model.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: LottieBuilder.asset(
                                        AppImageAssets.loading));
                              } else {
                                var snap = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                return InkWell(
                                  onTap: () {
                                    FocusNode focusNode = FocusNode();

                                    addReplaytest(
                                        context: context,
                                        postId: postId,
                                        snapshot: snapshot,
                                        focusNode: focusNode,
                                        commentid: commentid,
                                        commentname: name,
                                        tokenpost: tokenpost!);
                                  },
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          navigtonto(
                                              context,
                                              ProfileScreen(
                                                  otheruid: snap['uid']));
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(
                                              '${snap['image']}'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.66,
                                          child: Text(
                                            model.text != null &&
                                                    model.text != ''
                                                ? '${snap['name']} ${model.text}'
                                                : '${snap['name']}  Url ',
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                        );
                      },
                      itemCount: cubit.replays.length > 4
                          ? 4
                          : cubit.replays.length),
                ),
                if (cubit.replays.length > 3)
                  InkWell(
                      onTap: () {
                        FocusNode focusNode = FocusNode();

                        addReplaytest(
                            context: context,
                            postId: postId,
                            snapshot: snapshot,
                            focusNode: focusNode,
                            commentid: commentid,
                            commentname: name,
                            tokenpost: tokenpost!);
                      },
                      child: Text(
                          'view ${cubit.replaysid.length} more replies')),
              ],
            );
          } else {
            return Container();
          }
        }),
  );
}
