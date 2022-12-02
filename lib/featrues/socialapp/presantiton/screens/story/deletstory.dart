import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

Future<dynamic> modelSheetToDeletStory(
    {required context, required String uidStory}) {
  var cubit = SocialappCubit.get(context);
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return InkWell(
        onTap: () {
          cubit.deletMyStory(uidStory);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showSnackBar(context: context, text: 'Delet Story Scussfully');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(
                Icons.delete,
                size: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Delet this Story'),
              )
            ],
          ),
        ),
      );
    },
  );
}
