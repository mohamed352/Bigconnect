import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/comments/addcomment.dart';

Widget textFromFieldForPost(
  {
   required context, 
    required String tokenpost,
    required List postid,
    required int index

  }
  ) {
  return Container(
    height: 30,
    width: MediaQuery.of(context).size.width * 0.682,
    //  padding: const EdgeInsets.symmetric(horizontal: 8),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        addcommenttest(
            context: context, postId: postid[index], tokenpost: tokenpost);
      },
      decoration: InputDecoration(
        hintText: 'write a comment ...',
        hintStyle: Theme.of(context).textTheme.caption!.copyWith(height: 0.7),
        // filled: true,
        fillColor: Colors.grey.shade300,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(style: BorderStyle.none)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(style: BorderStyle.none)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(style: BorderStyle.none)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(style: BorderStyle.none)),
      ),
    ),
  );
}
