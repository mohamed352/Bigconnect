import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/Notfications/notficatios.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';

Widget profilepanner3(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 40),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(SlideRight(page: const NotficationsScrenn()));
          },
          child: Container(
            height: 33,
            width: 115,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.blue, borderRadius: BorderRadius.circular(5)),
            child: const Center(
              child: Text(
                'Confirm',
                style:
                    TextStyle(color: Colors.white, height: 0.9, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context)
                .push(SlideRight(page: const NotficationsScrenn()));
          },
          child: Container(
            height: 33,
            width: 115,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5)),
            child: const Center(
              child: Text(
                'Delet',
                style:
                    TextStyle(color: Colors.black, height: 0.9, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
