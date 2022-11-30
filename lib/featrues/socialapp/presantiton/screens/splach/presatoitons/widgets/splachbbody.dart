

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/login/login.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/register/register.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

// ignore: camel_case_types
class Splach_Body extends StatefulWidget {
  const Splach_Body({super.key});

  @override
  State<Splach_Body> createState() => _Splach_BodyState();
}

// ignore: camel_case_types
class _Splach_BodyState extends State<Splach_Body>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fadeanimation;
  @override
  void initState() {
    super.initState();
    /*animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadeanimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!);
    animationController?.repeat(reverse: true);
  */
  }

  @override
  void dispose() {
    //animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppImageAssets.splachimage),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: 122,
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(SlideLeft(page: const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor('#75E6DA'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text(
                  'Singin',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
          ),
        ),
        SizedBox(
          width: 122,
          height: 40,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(SlideLeft(page: const RegisterScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#75E6DA'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Singup',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
        ),
        const Spacer()
      ],
    );
  }
}
