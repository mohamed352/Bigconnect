import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/data/models/storymodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/story/deletstory.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/fromattime.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

class ProfileStoryWidget extends StatelessWidget {
  final Story model;

  final dynamic date;
  final dynamic index;
  const ProfileStoryWidget({
    super.key,
    required this.model,
    required this.date,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: index != 0 ? model.uid : uidforall)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LottieBuilder.asset(AppImageAssets.loading));
          } else {
            var snap = snapshot.data!.docs[0].data() as Map<String, dynamic>;
            return Material(
              type: MaterialType.transparency,
              child: Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        navigtonto(context, ProfileScreen(otheruid: model.uid));
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(snap['image']),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        navigtonto(context, ProfileScreen(otheruid: model.uid));
                      },
                      child: Text(
                        snap['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 2.5),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      getTimeDifferenceFromNow(date.toDate()),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 2.5),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 27,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              modelSheetToDeletStory(
                                  context: context, uidStory: '${model.uid}');
                                  
                            },
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 27,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
