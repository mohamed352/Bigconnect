import 'package:flutter/material.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/data/models/commentmodel.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/editcomment.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

Future<dynamic> modelCommentSheet(
  Comments model,
  context,
  index,
  postId,
) async {
  var cubit = SocialappCubit.get(context);
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => SizedBox(
      height: uidforall == model.uid
          ? MediaQuery.of(context).size.height * 0.36
          : MediaQuery.of(context).size.height * 0.21,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: model.comments.contains(uidforall)
                        ? Colors.blue
                        : Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          cubit.likecomment(
                              tokenfcm: '${model.token}',
                              postid: postId,
                              comments: model.comments,
                              commentid: cubit.commentid[index]);
                        },
                        icon: const Icon(
                          Icons.thumb_up_alt,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            if (uidforall == model.uid)
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
              ),
            if (uidforall == model.uid)
              InkWell(
                onTap: () {
                  cubit.deletComment(postId, cubit.commentid[index]);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Delet Comment',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            if (uidforall == model.uid)
              Container(
                color: AppColors.grayshade,
                height: 1,
                width: double.infinity,
              ),
            if (uidforall == model.uid)
              InkWell(
                onTap: () {
                 
                  Navigator.of(context).pop();
                  navigtonto(
                      context,
                      EditComment(
                        commentId: model.commentid!,
                        image: model.image!,
                        postid: postId,
                        text: model.text!,
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
                        'edit Comment',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
            ),
            InkWell(
              onTap: () {
                cubit.hidecomment(
                    postId: postId, commentId: cubit.commentid[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.visibility_off,
                      size: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Hide Comment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.grayshade,
              height: 1,
              width: double.infinity,
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
                  children: const [
                    Icon(
                      Icons.info_rounded,
                      size: 35,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Report Comment',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
