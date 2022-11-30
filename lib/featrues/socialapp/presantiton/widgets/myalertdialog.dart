import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';

Widget myAlertDiloag(context) {
  var cubit = SocialappCubit.get(context);
  return AlertDialog(
    backgroundColor: cubit.isdark == false ? Colors.white : AppColors.dark,
    title: const Text(
      'Support',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Report ',
            style: TextStyle(color: Colors.blue),
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            maxLines: 15,
            minLines: 1,
            decoration: const InputDecoration(
                label: Text('Write here'),
                labelStyle: TextStyle(color: Colors.blueAccent)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 33,
                  width: 85,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Your report send ')));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 33,
                  width: 85,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
  required context,
  required String text,
  // required Color? color,
  bool? isError,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isError == true ? Colors.red : Colors.grey.shade800,
      content: Container(
          height: isError == true ? 29 : 20,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: isError == true ? 14 : 17),
          )),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
