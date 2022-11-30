import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/icon.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/friendsitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

class PepoleReact extends StatelessWidget {
  final List<dynamic> likes;

  const PepoleReact({super.key, required this.likes});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state){

        return SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            size: 28,
                          )),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'People who reacted',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            navigtonto(context, const SearchScreen());
                          },
                          icon: const Icon(
                            IconBroken.search,
                            size: 28,
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                for (int i = 0; likes.length > i; i++)
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid', isEqualTo: likes[i])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: LottieBuilder.asset(
                                  AppImageAssets.loading));
                        } else {
                          return Conditional.single(
                              context: context,
                              conditionBuilder: (context) => likes.isNotEmpty,
                              widgetBuilder: (context) => ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var snap = snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                    return buildpepolewhoreactitem(
                                        context: context,
                                        uid: snap['uid'],
                                        image: snap['image'],
                                        text: snap['name'],
                                        bio: snap['bio'],
                                        friendrequset: snap['friendsRquest'],
                                        token:snap['token'],
                                        );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: snapshot.data!.docs.length),
                              fallbackBuilder: (context) => Center(
                                  child: LottieBuilder.asset(
                                      AppImageAssets.empty1)));
                        }
                      })
              ],
            ),
          ),
        ));
      },
    );
  }
}
