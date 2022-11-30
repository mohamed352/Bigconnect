import 'package:flutter/material.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Widget profilepannel1({
  required context,
  required String otheruid,
  required String token1,
  required List friendsrequest,
}) {
  var cubit = SocialappCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(top: 14, left: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            //  print(cubit.allnotifid.indexOf('c13ca600-5134-11ed-98fa-bfa9bdbd719c'));
            friendsrequest.contains(uidforall)
                ? cubit.cancelfriend(otheruid: otheruid)
                : cubit.sendfriendrquest(
                    friendid: otheruid,
                    token: token1,
                  );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.only(
              top: 9,
              left: friendsrequest.contains(uidforall) ? 100 : 88,
            ),
            decoration: BoxDecoration(
                color: AppColors.blue, borderRadius: BorderRadius.circular(7)),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  friendsrequest.contains(uidforall)
                      ? Icons.person_remove
                      : Icons.person_add,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  friendsrequest.contains(uidforall) ? 'Cancel ' : 'Add Frined',
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          margin: const EdgeInsets.only(left: 2),
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
                    color: cubit.isdark == true
                        ? AppColors.dark
                        : Colors.grey.shade500,
                    padding: EdgeInsets.zero,
                    //   margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.38,
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
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person_remove_alt_1_sharp,
                                    size: 30,
                                  )),
                              const Text(
                                'Unfriend',
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
                                  Icons.block,
                                  size: 30,
                                )),
                            const Text(
                              'bloc',
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
                        InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.info_sharp,
                                    size: 30,
                                  )),
                              const Text(
                                'Report profile',
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
                        InkWell(
                          onTap: () {
                            navigtonto(context, const SearchScreen());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    navigtonto(context, const SearchScreen());
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    size: 30,
                                  )),
                              const Text(
                                'Search',
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
                        InkWell(
                          onTap: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 30,
                                  )),
                              const Text(
                                'Send Like',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, height: 2.5),
                              )
                            ],
                          ),
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
