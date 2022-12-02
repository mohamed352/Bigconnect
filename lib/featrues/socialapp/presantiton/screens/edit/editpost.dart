import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/loadinginscreen.dart';

// ignore: must_be_immutable
class EditPost extends StatelessWidget {
  String? text;
  String? image;
  final String name;
  final String postId;
  final String userimage;

  EditPost(
      {super.key,
      this.image,
      this.text,
      required this.name,
      required this.userimage,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    textController.text = text!;
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) async {
        if (state is EditPostDone) {
          await SocialappCubit.get(context). playLoadingAudioEdit(context);
        }
      },
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        File? postimage = cubit.pickpostimageu;

        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Edit post',
                                style: TextStyle(fontSize: 20, height: 1.2),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 35,
                              width: 85,
                              child: ElevatedButton(
                                onPressed: () {
                                  cubit.ispostloading = true;
                                  if (postimage != null) {
                                    cubit.uploadimageforpostedit(
                                        uid: postId, text: textController.text);
                                  } else {
                                    cubit.editpost(
                                        uid: postId, text: textController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: textController.text == ''
                                        ? Colors.grey
                                        : Colors.blue),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: const Text('Edit'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(userimage),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'public',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: textController,
                          maxLines: 15,
                          minLines: 1,
                          onChanged: (value) {
                            cubit.onchangestate();
                          },
                          keyboardType: TextInputType.text,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      if (image != '' || postimage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: postimage == null
                                      ? NetworkImage('$image')
                                      : FileImage(postimage) as ImageProvider,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  image = '';
                                  cubit.clearupdatepostphoto();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 33,
                                ))
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          cubit.pickimagepost();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.photo_library_rounded,
                              size: 35,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'photo/video',
                              style: TextStyle(),
                            ),
                          ],
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
                ),
              ),
            ),
            if (cubit.ispostloading) loadinOnScreen(context)
          ],
        );
      },
    );
  }
}
