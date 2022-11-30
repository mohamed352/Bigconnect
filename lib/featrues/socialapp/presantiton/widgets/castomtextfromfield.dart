

import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/textstule.dart';

Widget castomfromfield(context,
    {String? hedlinetext,
    required String hinttext,
    TextEditingController? controller,
    required TextInputType type,
    IconData? prefix,
    required Function vildate,
    Function? onchange,
    Function? onsubmaited,
    bool isscure = false,
    IconData? suffixicon,
    Function? onpressedicon,
    Function? ontap,
    int? maxlines,
    FocusScopeNode? focusNode,
    Color color = AppColors.grayshade,
    TextInputAction? textInputAction}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hedlinetext ?? '',
          style: KTextStyle.textFieldHeading,
        ),
        Container(
          height: 55,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            style:const  TextStyle(color: Colors.black),
            onChanged: (value) {
              if (onchange != null) {
                onchange(value);
              }
            },
            onTap: () {
              if (ontap != null) {
                ontap();
              }
            },
            onFieldSubmitted: (value) {
              onsubmaited != null ? onsubmaited(value) : null;
            },
            validator: (value) {
              return vildate(value);
            },
            keyboardType: type,
            controller: controller,
            maxLines: maxlines,
            focusNode: focusNode,
            obscureText: isscure,
            enableSuggestions: true,
            textInputAction: textInputAction,
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 12, height: 0.2),
                hintText: hinttext,
                hintStyle: TextStyle(
                    color: SocialappCubit.get(context).isdark == false
                        ? AppColors.grayshade
                        : Colors.black),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: Icon(prefix),
                suffixIcon: suffixicon != null
                    ? IconButton(
                        onPressed: () {
                          onpressedicon!();
                        },
                        icon: Icon(suffixicon))
                    : null),
          ),
        )
      ],
    ),
  );
}
