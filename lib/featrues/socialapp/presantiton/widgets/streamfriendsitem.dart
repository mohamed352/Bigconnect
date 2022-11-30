import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/friend/friendsprofile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/buildfriendsitem.dart';

Widget stremFriends({required context, required String otheruid, required String uid}) {
  var cubit = SocialappCubit.get(context);
  return Conditional.single(
    context: context,
    conditionBuilder: (context) =>
        uid == uidforall || cubit.usermodel!.friends.contains(otheruid),
    widgetBuilder: (context) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(otheruid)
              .collection('friends')
              .snapshots(),
          builder: (context, snapshotfriends) {
            if (!snapshotfriends.hasData) {
              return Center(
                  child: LottieBuilder.asset(AppImageAssets.empty1));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Friends',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text('${snapshotfriends.data!.docs.length} friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(height: 1)),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(AlignAnimationsRoute(
                                  page: const FriendsProfile()));
                            },
                            child: const Text(
                              'Find',
                              style:
                                  TextStyle(color: AppColors.blue, height: 1.5),
                            )),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      height: 150,
                      width: double.infinity,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          // shrinkWrap: true,
                          // physics:
                          //     const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var friendsdate = snapshotfriends.data!.docs[index]
                                .data() as Map<String, dynamic>;
                            return Friendsitem(
                              image: friendsdate['image'],
                              name: friendsdate['name'],
                              uid: friendsdate['uid'],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 8,
                              ),
                          itemCount: snapshotfriends.data!.docs.length),
                    )
                  ],
                ),
              );
            }
          });
    },
    fallbackBuilder: (context) => Container(),
  );
}
