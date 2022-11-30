import 'package:flutter/material.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Widget buildfriendsitem(
    {context,
    required String image,
    required String uid,
    required String text,
    required String bio}) {
  return InkWell(
    onTap: () {
      navigtonto(context, ProfileScreen(otheruid: uid));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              Text(
                bio,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildpepolewhoreactitem({
  context,
  required String image,
  required String uid,
  required String text,
  required String bio,
  required List friendrequset,
  required String token,
}) {
  var cubit = SocialappCubit.get(context);
  return InkWell(
    onTap: () {
      navigtonto(context, ProfileScreen(otheruid: uid));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(image),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red.shade600,
                child: const Icon(
                  Icons.favorite,
                  size: 16,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              Text(
                bio,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
          if (cubit.usermodel!.friends.contains(uid) == false) const Spacer(),
          if (cubit.usermodel!.friends.contains(uid) == false)
            ElevatedButton(
                onPressed: () {
                  friendrequset.contains(uidforall)
                      ? cubit.cancelfriend(otheruid: uid)
                      : cubit.sendfriendrquest(
                          friendid: uid,
                          token: token,
                        );
                },
                child: Text(
                  friendrequset.contains(uidforall) ? 'Cancel ' : 'Add Frined',
                ))
        ],
      ),
    ),
  );
}
