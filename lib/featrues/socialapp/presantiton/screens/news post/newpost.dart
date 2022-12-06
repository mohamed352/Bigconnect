import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/loadinginscreen.dart';

// ignore: must_be_immutable
class NewPosts extends StatelessWidget {
  final textController = TextEditingController();
  NewPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) async {
        if (state is SocialCeratPostScsfully) {
          await SocialappCubit.get(context).playLoadingAudio(context);
        }
      },
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        File? postimage = cubit.postgaleryimage;
        File? postcamerimage = cubit.postgcameraimage;

        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onScaleStart: (d) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                                    'Cerat post',
                                    style: TextStyle(fontSize: 20, height: 1.2),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: 35,
                                  width: 85,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      cubit.ispostloading = true;
                                      if (postimage == null &&
                                          postcamerimage == null) {
                                        cubit.ceratposts(
                                            text: textController.text);
                                      } else if (postimage != null &&
                                          postcamerimage == null) {
                                        cubit.uploadpostimage(
                                            text: textController.text);
                                      } else if (postimage == null &&
                                          postcamerimage != null) {
                                        cubit.uploadpostcamerimage(
                                            text: textController.text);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            textController.text != '' ||
                                                    postimage != null ||
                                                    postcamerimage != null
                                                ? Colors.blue
                                                : Colors.grey),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: const Text('Share'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey[300],
                            margin: const EdgeInsets.only(bottom: 10),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage('${cubit.usermodel?.image}'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${cubit.usermodel?.name}',
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
                          TextFormField(
                            autofocus: false,
                            controller: textController,
                            maxLines: 15,
                            minLines: 1,
                            onChanged: (value) {
                              cubit.onchangestate();
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'What\'s on your Mind?',
                                hintStyle: TextStyle(
                                    color: cubit.isdark == false
                                        ? Colors.black
                                        : Colors.white),
                                border: InputBorder.none),
                          ),
                          if (postimage != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(postimage),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.clearpostphoto();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 25,
                                    ))
                              ],
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (postcamerimage != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(postcamerimage),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.clearpostphoto();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 25,
                                    ))
                              ],
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              cubit.pickpostimage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.photo_library_rounded,
                                    size: 35,
                                    color: Colors.green,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      'photo/video',
                                    ),
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
                              cubit.postgcamerimage();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 35,
                                    color: AppColors.blue,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      'Camera',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.sendGifToNewPost(
                                  context: context, text: textController.text);
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.gif_box,
                                  size: 45,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    'Gif',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
