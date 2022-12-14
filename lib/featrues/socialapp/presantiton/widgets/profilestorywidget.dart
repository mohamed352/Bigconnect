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
import 'package:story_view/story_view.dart';

// ignore: must_be_immutable
class ProfileStoryWidget extends StatelessWidget {
  final Story model;

  final dynamic date;
  final dynamic index;

  final dynamic indexstory;
  StoryController controller = StoryController();
  ProfileStoryWidget({
    super.key,
    required this.model,
    required this.date,
    required this.index,
    required this.indexstory,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(index != 0 ? model.uid : uidforall)
            //.where('uid', isEqualTo: index != 0 ? model.uid : uidforall)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LottieBuilder.asset(AppImageAssets.loading));
          } else {
            var snap = snapshot.data!.data() as Map<String, dynamic>;
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
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        navigtonto(context, ProfileScreen(otheruid: model.uid));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.56,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snap['name']}',
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(getTimeDifferenceFromNow(date.toDate(), true),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                        InkWell(
                            onTap: () {
                              controller.pause();
                              modelSheetToDeletStory(
                                  capiton: model.capiton[
                                      indexstory < model.capiton.length
                                          ? indexstory
                                          : 0],
                                  datetime: date,
                                  image: model.storyimage,
                                  storyimage: model.storyimage[indexstory],
                                  index: indexstory,
                                  context: context,
                                  uidStory: '${model.uid}');
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 30,
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
