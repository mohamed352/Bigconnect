import 'package:flutter/material.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

Future<dynamic> modelSheetToDeletStory({
  required context,
  required String uidStory,
  String? capiton,
  required String storyimage,
  required dynamic datetime,
  required List image,
  required int index,
}) {
  var cubit = SocialappCubit.get(context);
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: image.length > 1
            ? MediaQuery.of(context).size.height * 0.15
            : MediaQuery.of(context).size.height * 0.08,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                cubit.deletMyStory(uidStory);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                showSnackBar(context: context, text: 'Delet Story Scussfully');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.delete,
                      size: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Delet all Story'),
                    )
                  ],
                ),
              ),
            ),
            if (image.length > 1)
              InkWell(
                onTap: () {
                  cubit.deletMyOneStory(
                      uidstory: uidStory,
                      capiton: capiton,
                      storyimage: storyimage,
                      datetime: datetime,
                      image: image);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  showSnackBar(
                      context: context,
                      text: 'Delet only one Story Scussfully');
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.delete,
                        size: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Delet only this Story'),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}
