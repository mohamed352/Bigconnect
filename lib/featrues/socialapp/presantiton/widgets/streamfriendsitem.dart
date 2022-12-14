import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/friend/friendsprofile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/buildfriendsitem.dart';

Widget stremFriends(
    {required context,
    required String otheruid,
    required String uid,
    required List friends}) {
  //var cubit = SocialappCubit.get(context);

  return Conditional.single(
    context: context,
    conditionBuilder: (context) => friends.length - 1 > 0,
    widgetBuilder: (
      context,
    ) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(otheruid)
              .collection('friends')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: LottieBuilder.asset(AppImageAssets.empty1));
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Friends',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text('${friends.length - 1} friends',
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var snap = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            return Friendsitem(
                              uid: snap['uid'],
                            );
                          },
                          separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5)),
                          itemCount: snapshot.data!.docs.length),
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
