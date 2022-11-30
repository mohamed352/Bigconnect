import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

// ignore: must_be_immutable
class Friendsitem extends StatelessWidget {
  String? image;
  String? name;
  String uid;
  Friendsitem({super.key, this.image, this.name, required this.uid});

  @override
  Widget build(BuildContext context) {
   // var cubit = SocialappCubit.get(context);

    return Row(
      // spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(SlideRight(page: ProfileScreen(otheruid: uid)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height - 645,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage('$image'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: 95,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                '$name',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
