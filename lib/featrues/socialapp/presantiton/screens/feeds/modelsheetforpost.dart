import 'package:flutter/material.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/edit/editpost.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Future<dynamic> modelSheetForPost({
  required context,
  required String? uid1,
  required String? image,
  required String? text,
  required String? name,
  required String? postId,
  required String? postimage,
  required List postid,
  required int index,
}) {
  var cubit1 = SocialappCubit.get(context);
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.zero,
      height: uid1 == uidforall
          ? MediaQuery.of(context).size.height * 0.47
          : MediaQuery.of(context).size.height * 0.41,
      //color: AppColors.grayshade,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          Container(
            color: Colors.grey,
            height: 4,
            width: 45,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(SlideRight(
                  page: ProfileScreen(
                otheruid: uid1,
              )));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage('$image'),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name',
                        style: TextStyle(
                            color: cubit1.isdark == false
                                ? Colors.black
                                : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See profile',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          if (uid1 == uidforall)
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
              // margin: const EdgeInsets.all(7),
            ),
          if (uid1 == uidforall)
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                navigtonto(
                    context,
                    EditPost(
                      text: text,
                      image: postimage,
                      name: name!,
                      postId: postId!,
                      userimage: image!,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.edit,
                      size: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Edit post',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          if (uid1 == uidforall)
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
              // margin: const EdgeInsets.all(7),
            ),
          if (uid1 == uidforall)
            InkWell(
              onTap: () {
                cubit1.deletpost(postid[index],context);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delet post',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'if you delet post can\'t return it',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          Container(
            color: AppColors.grayshade,
            height: 1,
            width: double.infinity,
            // margin: const EdgeInsets.all(7),
          ),
          InkWell(
            onTap: () {
              cubit1.hidepost(postid[index],context);
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.visibility_off,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hide post',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See fewer posts like this',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.grayshade,
            height: 1,
            width: double.infinity,
            //  margin: const EdgeInsets.all(7),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => myAlertDiloag(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.report,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Report post',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'i\'m concerend about this post ',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (uid1 != uidforall)
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
              //     margin: const EdgeInsets.all(7),
            ),
          if (uid1 != uidforall)
            InkWell(
              onTap: () {
                cubit1.deletfriend(uid1!);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cancel,
                      size: 35,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unfollow $name',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Stop seeing posts from this account ',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          Container(
            color: AppColors.grayshade,
            height: 1,
            width: double.infinity,
            // margin: const EdgeInsets.all(7),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.file_copy,
                    size: 35,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Copy link',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
