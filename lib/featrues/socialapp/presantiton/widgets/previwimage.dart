import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';

import 'myalertdialog.dart';

Future<dynamic> pageView(
    {required context,
    required String image,
    PaletteGenerator? paletteGenerator}) async {
  SystemUiOverlayStyle current = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: paletteGenerator?.darkMutedColor?.color ?? Colors.black,
      statusBarIconBrightness: Brightness.light);

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: paletteGenerator?.darkMutedColor?.color ?? Colors.black,
    builder: (context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: current,
        child: GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return InkWell(
                  onTap: () {
                     Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    SocialappCubit.get(context)
                        .saveImagetoGallery(image);
                    showSnackBar(
                        context: context,
                        text: 'Image saved to this phone');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.save_alt,
                          size: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Save to phone'),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: 1 / 2,
              child: Image.network(image),
            ),
          ),
        ),
      );
    },
  );
}
