import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';

class CeratStory extends StatelessWidget {
  final PaletteGenerator paletteGenerator;

  const CeratStory({
    super.key,
    required this.paletteGenerator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) async {
        if (state is UploadStoryImageDone) {
          await SocialappCubit.get(context).playLoadingAudio(context);
        }
      },
      builder: (context, state) {
        SystemUiOverlayStyle curantstyle = SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: paletteGenerator.dominantColor?.color,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light);
        TextEditingController controller = TextEditingController();
        var cubit = SocialappCubit.get(context);
        File? storyimage = cubit.pickstoryimage;

        return AnnotatedRegion(
          value: curantstyle,
          child: Scaffold(
            backgroundColor: paletteGenerator.dominantColor?.color,
            body: storyimage != null
                ? SafeArea(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        AspectRatio(
                            aspectRatio: 1 / 2,
                            child: Center(
                              child: Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  state is! UploadStoryImageLoading
                                      ? Image.file(storyimage)
                                      : LottieBuilder.asset(
                                          AppImageAssets.loading),
                                  IconButton(
                                      onPressed: () {
                                        cubit.deletstoryimage();
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: paletteGenerator.darkMutedColor
                                            ?.color, // Colors.white.withOpacity(0.8),
                                        size: 35,
                                      )),
                                ],
                              ),
                            )),
                        Container(
                          height: 45,
                          margin: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.text,
                            cursorHeight: 25,
                            cursorWidth: 1.5,
                            textAlignVertical: TextAlignVertical.bottom,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.send,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              fillColor: paletteGenerator.darkMutedColor?.color,
                              filled: true,
                              border: InputBorder.none,
                              hintText: 'Write here',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.none)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.uploadStoryimage(
                                        capiton: controller.text);
                                  },
                                  icon: const Icon(Icons.send)),
                              alignLabelWithHint: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
