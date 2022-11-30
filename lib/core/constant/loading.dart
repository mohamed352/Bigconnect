import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';

import '../../featrues/socialapp/presantiton/style/themapp.dart';

Widget loading(context) {
  var cubit = SocialappCubit.get(context);
  return AnnotatedRegion(
    value: cubit.isdark == false ? valuelight : valuedark,
    child: Scaffold(
        body: Center(child: LottieBuilder.asset(AppImageAssets.loading))),
  );
}
