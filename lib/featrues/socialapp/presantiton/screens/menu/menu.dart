import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/friend/friendsprofile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/editprofile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/setting/setting.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/icon.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

import '../../cubit/socialapp_cubit.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Menu',
                      style: TextStyle(fontSize: 23),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        navigtonto(context, const SettingScreen());
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.grayshade,
                        child: Icon(Icons.settings,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        navigtonto(context, const SearchScreen());
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.grayshade,
                        child: Icon(IconBroken.search,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(SlideRight(
                      page: ProfileScreen(
                    otheruid: uidforall,
                  )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 19,
                        backgroundImage:
                            NetworkImage('${cubit.usermodel?.image}'),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              '${cubit.usermodel?.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: cubit.isdark == false
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'See your profile',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.all(7),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(SlideLeft(page: Editprofile()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Edit your profile',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.all(7),
              ),
              InkWell(
                onTap: () {
                  navigtonto(context, const FriendsProfile());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.people,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Frindes',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.all(7),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => myAlertDiloag(context),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Help & support',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.all(7),
              ),
              InkWell(
                onTap: () {
                  navigtonto(context, const SettingScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Settings & privacy',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.all(7),
              ),
            ],
          ),
        );
      },
    );
  }
}
