import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/edit/editpubilcrules.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/themapp.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/buildpostitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/previwimage.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/profilebannel1.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/profilebanner3.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/profilepanner2.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/profilepanner4.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/streamfriendsitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/textfromfieldsearch.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  dynamic otheruid;
  ProfileScreen({super.key, required this.otheruid});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) async {
        if (state is SocialTest) {
          await  SocialappCubit.get(context). playLikeSound();
        }
        if (state is DeletPostDone) {
          showSnackBar(
            context: context,
            text: 'Delet post sucsfully',
          );
        }
        if (state is HidePostDone) {
          showSnackBar(
            context: context,
            text: 'Hide post sucsfully',
          );
        }
      },
      builder: (context, state) {
        // ignore: unused_local_variable
        SystemUiOverlayStyle current = SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark);
        var cubit = SocialappCubit.get(context);
        return AnnotatedRegion(
          value: cubit.isdark == false ? valuelight : valuedark,
          child: Scaffold(
            body: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otheruid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: LottieBuilder.asset(AppImageAssets.loading));
                  } else {
                    var snap = snapshot.data!.data() as Map<String, dynamic>;
                    return SafeArea(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_sharp,
                                      size: 30,
                                    )),
                                textfromfieldsearch(context)
                              ],
                            ),
                            Container(
                              color: cubit.isdark == false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                              height: 2,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                            ),
                            InkWell(
                              onTap: () async {
                                PaletteGenerator paletteGenerator =
                                    await PaletteGenerator.fromImageProvider(
                                        NetworkImage(snap['cover']),
                                        maximumColorCount: 20,
                                        size: const Size(200, 200));
                                pageView(
                                    image: snap['cover'],
                                    context: context,
                                    paletteGenerator: paletteGenerator);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                padding: EdgeInsets.zero,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.topCenter,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.265,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6),
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(snap['cover']),
                                            )),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        PaletteGenerator paletteGenerator =
                                            await PaletteGenerator
                                                .fromImageProvider(
                                                    NetworkImage(snap['image']),
                                                    maximumColorCount: 20,
                                                    size: const Size(200, 200));
                                        pageView(
                                            image: snap['image'],
                                            context: context,
                                            paletteGenerator: paletteGenerator);
                                      },
                                      child: CircleAvatar(
                                        radius: 85,
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: CircleAvatar(
                                          radius: 80,
                                          backgroundImage:
                                              NetworkImage(snap['image']),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snap['name'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snap['bio'],
                              style: Theme.of(context).textTheme.caption,
                            ),
                            if (snap['uid'] != uidforall &&
                                snap['friends'].contains(uidforall) == false &&
                                cubit.usermodel!.friendsRquest
                                        .contains(otheruid) ==
                                    false)
                              profilepannel1(
                                  context: context,
                                  otheruid: otheruid,
                                  token1: snap['token'],
                                  friendsrequest: snap['friendsRquest']),
                            if (snap['uid'] == uidforall)
                              profilebanner2(context: context),
                            if (cubit.usermodel?.friendsRquest != null &&
                                cubit.usermodel!.friendsRquest
                                    .contains(otheruid))
                              profilepanner3(context),
                            if (snap['friends'] != null &&
                                snap['friends'].contains(uidforall) &&
                                snap['uid'] != uidforall)
                              profilebanner4(
                                  context: context, otheruid: otheruid),
                            Container(
                              color: cubit.isdark == false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade800,
                              padding: const EdgeInsets.all(10),
                              height: 10,
                              margin: const EdgeInsets.only(top: 7),
                            ),
                            Container(
                              color: cubit.isdark == false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                              height: 2,
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 8),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Details',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.alarm,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Joinned ${DateFormat("yyyy-MM-dd").format(snap['time'].toDate())}',
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.school,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        snap['education'] ?? 'Educations',
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        snap['socialsituation'] ??
                                            'Socialsituation',
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.home,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        snap['locaiton'] ?? 'Locaitions',
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  if (snap['uid'] == uidforall)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: MediaQuery.of(context).size.width,
                                      child: OutlinedButton(
                                          style: const ButtonStyle(
                                            enableFeedback: true,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                SlideRight(
                                                    page: EditPubilcRules()));
                                          },
                                          child: const Text(
                                              'Edit public details')),
                                    )
                                ],
                              ),
                            ),
                            stremFriends(
                                otheruid: otheruid,
                                uid: snap['uid'],
                                
                                friends: snap['friends'],
                                context: context),
                            if (cubit.usermodel!.friends.length - 1 > 0)
                              Container(
                                color: cubit.isdark == false
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade800,
                                height: 13,
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 5),
                              ),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .where('uid', isEqualTo: otheruid)
                                    // .orderBy('datatime', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot2) {
                                  if (!snapshot2.hasData) {
                                    return Center(
                                        child: LottieBuilder.asset(
                                            AppImageAssets.loading));
                                  } else {
                                    cubit.mypostid = [];
                                    for (var element in snapshot2.data!.docs) {
                                      cubit.mypostid.add(element.id);
                                    }
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var snap2 =
                                              snapshot2.data!.docs[index].data()
                                                  as Map<String, dynamic>;
                                          return buildpostitem(
                                            context,
                                            index,
                                            name: snap2['name'],
                                            datatime: snap2['datatime'],
                                            postId: snap2['postid'],
                                            text: snap2['text'],
                                            tokenpost: snap2['token'],
                                            uid1: snap2['uid'],
                                            image: snap2['image'],
                                            postimage: snap2['postimage'],
                                            likes: snap2['likes'],
                                            show: snap2['show'],
                                            commentint: snap2['commentint'],
                                            postid: cubit.mypostid,
                                            showpostfriend: snap['friends']
                                                .contains(otheruid),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Container(
                                              color: cubit.isdark == false
                                                  ? Colors.grey.shade300
                                                  : Colors.grey.shade800,
                                              padding: const EdgeInsets.all(10),
                                              height: 5,
                                            ),
                                        itemCount: snapshot2.data!.docs.length);
                                  }
                                })
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ),
        );
      },
    );
  }
}
