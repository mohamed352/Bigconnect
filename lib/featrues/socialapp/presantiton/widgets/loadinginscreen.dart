import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';

Widget loadinOnScreen(context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    color: Colors.white.withOpacity(0.09),
    child: LottieBuilder.asset(AppImageAssets.loading),
  );
}
