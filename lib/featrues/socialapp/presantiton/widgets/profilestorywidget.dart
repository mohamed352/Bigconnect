import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/data/models/storymodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/fromattime.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

class ProfileStoryWidget extends StatelessWidget {
  final Story model;
  final dynamic date;
  const ProfileStoryWidget({
    super.key,
    required this.model,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                navigtonto(context, ProfileScreen(otheruid: model.uid));
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.userimage}'),
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
                '${model.name}',
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
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
