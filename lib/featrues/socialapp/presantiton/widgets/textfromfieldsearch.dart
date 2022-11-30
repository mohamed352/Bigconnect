import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

Widget textfromfieldsearch(context) {
  var cubit = SocialappCubit.get(context);
  return Container(
    height: 35,
    padding: EdgeInsets.zero,
    margin: const EdgeInsets.only(top: 4),
    // margin: const EdgeInsets.symmetric(horizontal: 5),
    width: MediaQuery.of(context).size.width * 0.85,
    child: TextFormField(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());

        Navigator.of(context).push(SlideRight(page: const SearchScreen()));
      },
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: Theme.of(context).textTheme.caption!.copyWith(
              height: 0.7,
              color: cubit.isdark == false ? Colors.grey : Colors.white,
            ),
        filled: true,
        fillColor:
            cubit.isdark == false ? Colors.grey.shade300 : Colors.grey.shade800,
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
