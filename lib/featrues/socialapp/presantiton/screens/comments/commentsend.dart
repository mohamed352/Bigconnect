import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';

Widget commentsend(
    {required context,
    required TextEditingController commenControler,
    required String postId,
    required String token}) {
  var cubit = SocialappCubit.get(context);
  File? commentimage = cubit.commentimage;
  return Positioned(
    bottom: 0,
    child: SizedBox(
      height: 58,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    cubit.sendGif(
                        context: context,
                        postid: postId,
                        tokenfcm: token,
                        text: commenControler.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 5,
                    ),
                    child: Icon(
                      Icons.gif_box,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: const EdgeInsets.only(
                    top: 7,
                    left: 6,
                    right: 6,
                  ),
                  width: MediaQuery.of(context).size.width * 0.875,
                  child: TextFormField(
                    controller: commenControler,
                    keyboardType: TextInputType.text,
                    maxLines: 15,
                    minLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cubit.isdark == false
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(style: BorderStyle.none)),
                      hintText: 'Write a comment',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: cubit.isdark == false
                              ? Colors.grey
                              : Colors.white),
                      suffixIcon: IconButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          cubit.iscommentloading = true;
                          if (commentimage != null) {
                            cubit.uploadcommentcamerimage(
                                postid: postId,
                                token: token,
                                text: commenControler.text);
                          } else {
                            cubit.postcomment(
                              postid: postId,
                              tokenfcm: token,
                              text: commenControler.text,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: InkWell(
                            onTap: () {
                              cubit.commentpickimage();
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            )),
                      ),
                      contentPadding: const EdgeInsets.only(
                        top: 10,
                        left: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
