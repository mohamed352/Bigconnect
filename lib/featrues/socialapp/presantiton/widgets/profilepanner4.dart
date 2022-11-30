import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/setting/setting.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Widget profilebanner4({required context, required String otheruid}) {
  var cubit = SocialappCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
              color: AppColors.blue, borderRadius: BorderRadius.circular(7)),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.38,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                'Friend',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            cubit.deletfriend(otheruid);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(7)),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.38,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.person_remove,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  'Delet',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25))),
                  context: context,
                  builder: (context) => Container(
                    //color: AppColors.grayshade,
                    padding: EdgeInsets.zero,
                    //   margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          width: 45,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            navigtonto(context, const SettingScreen());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    navigtonto(context, const SettingScreen());
                                  },
                                  icon: const Icon(
                                    Icons.settings,
                                    size: 30,
                                  )),
                              const Text(
                                'Setting',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 2.5),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                          // margin: const EdgeInsets
                          //     .symmetric(vertical: 5),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.verified_user_sharp,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                            const Text(
                              'Verified',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, height: 2.5),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: double.infinity,
                          // margin: const EdgeInsets
                          //     .symmetric(vertical: 5),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              )),
        ),
      ],
    ),
  );
}
