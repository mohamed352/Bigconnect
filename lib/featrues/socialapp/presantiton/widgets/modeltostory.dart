import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';

Future<dynamic> modelToStory(context) {
  var cubit = SocialappCubit.get(context);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: cubit.isdark == false ? Colors.white : AppColors.dark,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        InkWell(
          onTap: () {
            cubit.sendGifToStory(context: context, capiton: '');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Icon(
                  Icons.gif_box,
                  size: 45,
                  color: Colors.red,
                ),
                Text('Gif')
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            cubit.storyimage(
              context,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Icon(
                  Icons.image_outlined,
                  size: 45,
                  color: Colors.green,
                ),
                Text('Image')
              ],
            ),
          ),
        )
      ],
    ),
  );
}
