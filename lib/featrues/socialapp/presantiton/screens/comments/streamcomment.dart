import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/commentitem.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/commentsend.dart';

Widget streamcomment(
    {required context,
    required AsyncSnapshot<dynamic> snapshot,
    required String postId,
    required TextEditingController commenControler,
    required String tokenpost}) {
  var cubit = SocialappCubit.get(context);
  File? commentimage = cubit.commentimage;

  return Conditional.single(
    context: context,
    conditionBuilder: (context) => snapshot.hasData == true,
    // && cubit.comments.isNotEmpty == true ,
    widgetBuilder: (context) {
      return Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 58,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const Text(
                        'Comments',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                if (cubit.comments.isEmpty)
                  Center(child: LottieBuilder.asset(AppImageAssets.empty2)),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildcommentitem(
                        cubit.comments[index],
                        context,
                        index,
                        postId,
                      );
                    },
                    itemCount: cubit.comments.length)
              ],
            ),
          ),
        ),
        if (cubit.iscommentloading)
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.09),
            child: LottieBuilder.asset(AppImageAssets.loading),
          ),
        commentsend(
          context: context,
          commenControler: commenControler,
          postId: postId,
          token: tokenpost,
        ),
        if (commentimage != null)
          Positioned(
            bottom: 40,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 8),
              child: Container(
                padding: EdgeInsets.zero,
                height: 250,
                width: MediaQuery.of(context).size.width - 180,
                // color: AppColors.blue,
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: FileImage(commentimage),
                            fit: BoxFit.cover,
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          cubit.clearcommentimage();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 25,
                        )),
                  ],
                ),
              ),
            ),
          ),
      ]);
    },
    fallbackBuilder: (context) =>
        Center(child: LottieBuilder.asset(AppImageAssets.empty2)),
  );
}
