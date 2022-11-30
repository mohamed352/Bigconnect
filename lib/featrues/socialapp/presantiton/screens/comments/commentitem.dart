import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:like_button/like_button.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/data/models/commentmodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/modelsheetcomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/fromattime.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/previwimage.dart';

Widget buildcommentitem(
  Comments model,
  context,
  index,
  postId,
) {
  var cubit = SocialappCubit.get(context);

  return Conditional.single(
    context: context,
    conditionBuilder: (context) => model.show != true,
    widgetBuilder: (context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              navigtonto(
                  context,
                  ProfileScreen(
                    otheruid: model.uid,
                  ));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage('${model.image}'),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigtonto(
                        context,
                        ProfileScreen(
                          otheruid: model.uid,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Text(
                      '${model.name}',
                      style: const TextStyle(
                          height: 1.4, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (model.text != '')
                  GestureDetector(
                    onLongPress: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      modelCommentSheet(model, context, index, postId);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.zero,
                      color:
                          cubit.isdark == false ? Colors.white : AppColors.dark,
                      child: Row(
                        children: [
                          Container(
                            //  color: AppColors.grayshade,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: cubit.isdark == false
                                    ? AppColors.grayshade
                                    : Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(20)),

                            child: Text(
                              '${model.text}',
                              style: const TextStyle(height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (model.text != '' && model.commentimage != '')
                  const SizedBox(
                    height: 5,
                  ),
                if (model.commentimage != '')
                  GestureDetector(
                    onTap: () async {
                      PaletteGenerator paletteGenerator =
                          await PaletteGenerator.fromImageProvider(
                              NetworkImage('${model.commentimage}'),
                              maximumColorCount: 20,
                              size: const Size(200, 200));
                      pageView(
                          context: context,
                          image: '${model.commentimage}',
                          paletteGenerator: paletteGenerator);
                    },
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                          alignment: AlignmentDirectional.topStart,
                          isAntiAlias: true,
                          fit: BoxFit.contain,
                          matchTextDirection: true,
                          '${model.commentimage}'),
                    ),
                  ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      getTimeDifferenceFromNow(model.datatime
                          .toDate()), //  tago.format(model.datatime.toDate()),
                      // '${model.datatime}',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 2.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LikeButton(
                        isLiked: model.comments.contains(uidforall),
                        onTap: (isliked) async {
                          cubit.likecomment(
                              tokenfcm: '${model.token}',
                              postid: postId,
                              comments: model.comments,
                              commentid: cubit.commentid[index]);
                          return !isliked;
                        },
                        bubblesColor: const BubblesColor(
                            dotPrimaryColor: Colors.blueAccent,
                            dotSecondaryColor: Colors.blue),
                        circleColor: const CircleColor(
                            start: Colors.lightBlue,
                            end: Colors.lightBlueAccent),
                        likeBuilder: (isliked) {
                          return Icon(Icons.thumb_up_alt,
                              size: 25,
                              color: isliked ? Colors.blue : Colors.grey);
                        },
                        likeCount: model.comments.length,
                        countDecoration: (count, likeCount) {
                          return Text(
                            '${model.comments.length}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 2),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    },
    fallbackBuilder: (context) => Container(),
  );
}
