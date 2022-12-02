import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/data/models/getpost.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/news%20post/newpost.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/buildpostitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/buildstoryitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

// ignore: must_be_immutable
class Feedsscreen extends StatelessWidget {
  dynamic index1;

  Feedsscreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) async {
        if (state is Socialcameraimagepostepickerdone) {
          navigtonto(context, NewPosts());
        }
        if (state is SocialTest) {
          await SocialappCubit.get(context). playLikeSound();
        }
        if (state is DeletPostDone) {
          showSnackBar(
            context: context,
            text: 'Delet post sucsfully',
          );
        }
        if (state is HidePostDone) {
          showSnackBar(
            context: context,
            text: 'Hide post sucsfully',
          );
        }
      },
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);

        return RefreshIndicator(
          backgroundColor:
              cubit.isdark == false ? Colors.white : AppColors.dark,
          onRefresh: () async {
            cubit.getposts();
            cubit.getnotifications();
            cubit.getstoryes();
            return cubit.getuserdata();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            navigtonto(
                                context, ProfileScreen(otheruid: uidforall));
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                NetworkImage('${cubit.usermodel?.image}'),
                          ),
                        ),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 0.682,
                          //  padding: const EdgeInsets.symmetric(horizontal: 8),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextFormField(
                            autofocus: false,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.of(context)
                                  .push(SlideRight(page: NewPosts()));
                            },
                            decoration: InputDecoration(
                              hintText: 'Waht\'s on your mind?',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 0.7),
                              filled: true,
                              fillColor: cubit.isdark == false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade800,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        //const  Spacer(),
                        IconButton(
                            onPressed: () {
                              cubit.postgcamerimage();
                            },
                            icon: const Icon(
                              Icons.photo_camera,
                              color: AppColors.lightblue,
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  color: cubit.isdark == false
                      ? Colors.grey.shade300
                      : Colors.grey.shade800,
                  padding: const EdgeInsets.all(10),
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  height: 160,
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return StoryItem(
                          context: context,
                          model: cubit.stortlist[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 8,
                          ),
                      itemCount: cubit.storyid.length),
                ),
                Container(
                  color: cubit.isdark == false
                      ? Colors.grey.shade300
                      : Colors.grey.shade800,
                  padding: const EdgeInsets.all(10),
                  height: 10,
                ),
                Conditional.single(
                    context: context,
                    conditionBuilder: (context) => cubit.post.isNotEmpty,
                    widgetBuilder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            GetPosts model = cubit.post[index];

                            return buildpostitem(context, index,
                                name: model.name,
                                tokenpost: model.token!,
                                datatime: model.datatime,
                                text: model.text,
                                uid1: model.uid,
                                image: model.image,
                                postimage: model.postimage,
                                likes: model.likes,
                                postId: model.postid,
                                show: model.show,
                                commentint: model.commentint,
                                postid: cubit.posid,
                                showpostfriend: cubit.usermodel!.friends
                                    .contains(model.uid));
                          },
                          separatorBuilder: (context, index) => Container(
                            color: cubit.isdark == false
                                ? Colors.grey.shade300
                                : Colors.grey.shade800,
                            padding: const EdgeInsets.all(10),
                            height: 10,
                          ),
                          itemCount: cubit.post.length,
                        ),
                    fallbackBuilder: (context) {
                      return Center(child: Image.asset(AppImageAssets.nodate));
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
