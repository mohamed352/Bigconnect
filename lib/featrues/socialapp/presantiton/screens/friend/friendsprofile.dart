import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/friendsitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

class FriendsProfile extends StatelessWidget {
  const FriendsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
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
                          'Your Friends',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            navigtonto(context, const SearchScreen());
                          },
                          icon: const Icon(
                            Icons.person_search,
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
                Container(
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
                  child: TextFormField(
                    onTap: () {
                      navigtonto(context, const SearchScreen());
                    },
                    decoration: InputDecoration(
                      hintText: 'Search friends',
                      hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.5,
                          color: cubit.isdark == false
                              ? Colors.grey.shade300
                              : Colors.white),
                      filled: true,
                      prefixIcon: Icon(Icons.search,
                          color: cubit.isdark == false
                              ? Colors.grey.shade900
                              : Colors.white),
                      fillColor: cubit.isdark == false
                          ? Colors.grey.shade300
                          : Colors.grey.shade800,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Friends ${cubit.usermodel!.friends.length - 1}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 35),
                  ),
                ),
                for (int i = 0; i < cubit.usermodel!.friends.length-1; i++)
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid',
                              isEqualTo: cubit.usermodel!.friends[i ])
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child:
                                  LottieBuilder.asset(AppImageAssets.loading));
                        } else {
                          cubit.friendscount = [];
                          for (var element in snapshot.data!.docs) {
                            cubit.friendscount.add(element.id);
                          }
                          return Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  cubit.friendscount.isNotEmpty,
                              widgetBuilder: (context) => ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var snap = snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                    return buildfriendsitem(
                                        context: context,
                                        uid: snap['uid'],
                                        image: snap['image'],
                                        text: snap['name'],
                                        bio: snap['bio']);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: cubit.friendscount.length),
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
