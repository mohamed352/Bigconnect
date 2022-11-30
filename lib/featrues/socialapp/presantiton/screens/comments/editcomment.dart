import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

class EditComment extends StatelessWidget {
  final String postid;
  final String text;
  final String image;
  final String commentId;

  const EditComment(
      {super.key,
      required this.commentId,
      required this.text,
      required this.image,
      required this.postid});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentControaler = TextEditingController();
    commentControaler.text = text;
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {
        if (state is EditCommentDone) {
          showSnackBar(
              context: context,
              text: 'Edit comment done',
              );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);

        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 26,
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 120),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Edit',
                        style: TextStyle(height: 2.8, fontSize: 17),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: cubit.isdark == true
                      ? Colors.grey.shade600
                      : Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(image),
                      ),
                      Container(
                        height: 38,
                        width: MediaQuery.of(context).size.width * 0.8,
                        // padding: const EdgeInsets.symmetric(vertical: 4),
                        margin: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          autofocus: false,
                          cursorHeight: 22,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.text,
                          controller: commentControaler,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                              bottom: 5,
                              left: 10,
                            ),
                            fillColor: cubit.isdark == false
                                ? Colors.grey.shade300
                                : Colors.grey.shade800,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        cubit.editComment(
                            postid, commentId, commentControaler.text);
                      },
                      icon: const Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 45),
                          backgroundColor: cubit.isdark == true
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      label: const Text('Edit'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            commentControaler.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(120, 45),
                              backgroundColor: cubit.isdark == true
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text(
                            'Cancel',
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
