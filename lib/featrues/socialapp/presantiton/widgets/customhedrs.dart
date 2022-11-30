import 'package:flutter/material.dart';

import '../style/appcolor.dart';
import '../style/textstule.dart';

// ignore: must_be_immutable
class CustomHeders extends StatelessWidget {
  final String text;
  double? size;
  double? sizemargin;
  final Function()? onTap;
  CustomHeders(
      {super.key, required this.text, this.onTap, this.size, this.sizemargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: sizemargin ?? 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.whiteshade,
              size: 24,
            ),
          ),
          SizedBox(
            width: size ?? 16,
          ),
          Text(
            text,
            style: KTextStyle.headerTextStyle,
          )
        ],
      ),
    );
  }
}
