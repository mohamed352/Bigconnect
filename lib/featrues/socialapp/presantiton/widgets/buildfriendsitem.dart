import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

// ignore: must_be_immutable
class Friendsitem extends StatelessWidget {
  final String uid;

  const Friendsitem({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    //var cubit = SocialappCubit.get(context);

    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LottieBuilder.asset(AppImageAssets.empty1));
          } else {
            var snap = snapshot.data!.data() as Map<String, dynamic>;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            SlideRight(page: ProfileScreen(otheruid: uid)));
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
                ),
              ],
            );
          }
        });
  }
}
