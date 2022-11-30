import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/friend/friendsprofile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/buildfriendsitem.dart';

Widget stremFriends(
    {required context, required String otheruid, required String uid}) {
  var cubit = SocialappCubit.get(context);

  return Conditional.single(
    context: context,
    conditionBuilder: (context) =>
        uid == uidforall || cubit.usermodel!.friends.contains(otheruid),
    widgetBuilder: (
      context,
    ) {
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('${cubit.usermodel!.friends.length - 1} friends',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1)),
                  ],
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          AlignAnimationsRoute(page: const FriendsProfile()));
                    },
                    child: const Text(
                      'Find',
                      style: TextStyle(color: AppColors.blue, height: 1.5),
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
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Friendsitem(
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                  itemCount: cubit.usermodel!.friends.length - 1),
            )
          ],
        ),
      );
    },
    fallbackBuilder: (context) => Container(),
  );
}
