import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

// ignore: must_be_immutable
class Friendsitem extends StatelessWidget {
  dynamic index;
  Friendsitem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = SocialappCubit.get(context);

    return Row(
      // spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: cubit.usermodel!.friends[index ])
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: LottieBuilder.asset(AppImageAssets.empty1));
              } else {
                var snap =
                    snapshot.data!.docs[0].data() as Map<String, dynamic>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(SlideRight(
                            page: ProfileScreen(otheruid: snap['uid'])));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height - 645,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(snap['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 95,
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        snap['name'],
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
      ],
    );
  }
}
