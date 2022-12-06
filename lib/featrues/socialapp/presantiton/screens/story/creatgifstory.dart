import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/themapp.dart';

class CeratStoryGif extends StatelessWidget {
  final String gif;

  const CeratStoryGif({
    super.key,
    required this.gif,
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
        TextEditingController controller = TextEditingController();
        var cubit = SocialappCubit.get(context);

        return AnnotatedRegion(
          value: valuedark,
          child: Scaffold(
              backgroundColor: AppColors.dark,
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    AspectRatio(
                        aspectRatio: 1 / 2,
                        child: Center(
                          child: Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              cubit.isloadingStory
                                  ? LottieBuilder.asset(AppImageAssets.loading)
                                  : Image.network(gif,),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white.withOpacity(0.8),
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
                          fillColor: Colors.grey.shade800,
                          filled: true,
                          border: InputBorder.none,
                          hintText: 'Write here',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(style: BorderStyle.none)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(style: BorderStyle.none)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(style: BorderStyle.none)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(style: BorderStyle.none)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.isloadingStory = true;
                                cubit.uploadStory(
                                    image: gif, capiton: controller.text);
                              },
                              icon: const Icon(Icons.send)),
                          alignLabelWithHint: true,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
