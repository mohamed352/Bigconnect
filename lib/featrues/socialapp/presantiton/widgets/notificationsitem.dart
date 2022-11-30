import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/data/models/notifications.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/fromattime.dart';

Widget buildNotificationsitem(Notifications model, context, index) {
  var cubit = SocialappCubit.get(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(SlideRight(page: ProfileScreen(otheruid:model.uid )));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage('${model.image}'),
              radius: 35,
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                 onTap: () {
              Navigator.of(context).push(SlideRight(page: ProfileScreen(otheruid:model.uid )));
            },
                child: Text(
                  '${model.name} ',
                  style: const TextStyle(height: 2),
                ),
              ),
              if (State is DeletFristNotificationsDone)
                Text(
                  'You are now friends',
                  style: Theme.of(context).textTheme.caption,
                ),
              if (State is DeletFristNotificationsDone)
                Text(
                  'Request remove',
                  style: Theme.of(context).textTheme.caption,
                ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.accpetfriend(
                          notifiid: '${model.notfiid}',
                          token:'${model.token}',
                          bio1: '${model.bio}', 
                          // notifiid: cubit.notifid[index],
                          image: '${model.image}',
                          name: '${model.name}',
                          // otheruid: '${model.uid}',
                          frienduid: '${model.uid}');
                    },
                    child: Container(
                      height: 33,
                      width: 115,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                              color: Colors.white, height: 0.9, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      cubit.deletnotifications(
                          otheruid: '${model.uid}',
                          friendidfordelet: '${model.notfiid}');
                    },
                    child: Container(
                      height: 33,
                      width: 115,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          'Delet',
                          style: TextStyle(
                              color: Colors.black, height: 0.9, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(
          //   width: 0,
          // ),
          Text(
            getTimeDifferenceFromNow(model.datatime.toDate()),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    ],
  );
}
