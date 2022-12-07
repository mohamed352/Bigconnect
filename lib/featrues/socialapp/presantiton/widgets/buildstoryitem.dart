import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/data/models/storymodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/story/viewstory.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/modeltostory.dart';

import '../../../../config/endpoints.dart';

// ignore: must_be_immutable
class StoryItem extends StatelessWidget {
  late int index;
  late BuildContext context;
  Story model;
  StoryItem(
      {super.key,
      required this.index,
      required this.context,
      required this.model});

  @override
  Widget build(
    BuildContext context,
  ) {
    var cubit = SocialappCubit.get(context);
    final list = cubit.stortlist;
    final String = 'zmm';

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(index != 0
                ? model.uid
                : uidforall) // .where('uid', isEqualTo:index !=0 ? model.uid : uidforall
            // )
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: LottieBuilder.asset(AppImageAssets.loading));
          } else {
            var snap = snapshot.data!.data() as Map<String, dynamic>;
            return InkWell(
              enableFeedback: true,
              onTap: () {
                if (index == 0) {
                  modelToStory(context);

                  
                } else {
                  Navigator.of(context).push(DoubleAnimaitonsRoute(
                      page: ViewStory(
                    model: model,
                    storylist: list,
                    index: index,
                  )));
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height - 645,
                child: Stack(
                  alignment: index == 0
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.topStart,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: index == 0
                              ? NetworkImage('${cubit.usermodel?.image}')
                              : NetworkImage(model.storyimage[model.storyimage
                                  .indexOf(model.storyimage.last)]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (index == 0)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height - 10,
                        margin: const EdgeInsets.only(top: 105),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    if (index == 0)
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    if (index != 0)
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 7),
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(snap['image']),
                          ),
                        ),
                      ),
                    if (index == 0)
                      const Text(
                        'Creat story',
                        style: TextStyle(
                            color: Colors.black, fontSize: 12, height: 17),
                      ),
                    if (index != 0)
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          snap['name'],
                          maxLines: 2,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              height: 17),
                        ),
                      )
                  ],
                ),
              ),
            );
          }
        });
  }
}
