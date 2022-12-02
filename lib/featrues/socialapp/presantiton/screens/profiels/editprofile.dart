import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/icon.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/loadinginscreen.dart';

// ignore: must_be_immutable
class Editprofile extends StatelessWidget {
  // final fromkey = GlobalKey<FormState>();
  TextEditingController nameControelr = TextEditingController();
  TextEditingController bioControelr = TextEditingController();
  TextEditingController phoneControelr = TextEditingController();
  TextEditingController emailControelr = TextEditingController();

  Editprofile({super.key});

  @override
  Widget build(BuildContext context) {
    nameControelr.text = SocialappCubit.get(context).usermodel!.name!;
    bioControelr.text = SocialappCubit.get(context).usermodel!.bio!;
    phoneControelr.text = SocialappCubit.get(context).usermodel!.phone!;
    emailControelr.text = SocialappCubit.get(context).usermodel!.email!;
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) async {
        if (state is SocialCubitUploadUserScuflly) {
          await SocialappCubit.get(context)
              .playLoadingAudioEditProfile(context);
        }
      },
      builder: (context, state) {
        var usermodel = SocialappCubit.get(context).usermodel;
        var cubit = SocialappCubit.get(context);
        File? profileimage = SocialappCubit.get(context).profileimage;
        File? coverimage = SocialappCubit.get(context).coverimage;

        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Edit profile',
                                  style: TextStyle(fontSize: 20, height: 1.2),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 35,
                                width: 85,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cubit.isEditProfileLoading = true;

                                    if (cubit.coverimage != null &&
                                        cubit.profileimage == null) {
                                      cubit.uploadcoverimage(
                                          name: nameControelr.text,
                                          phone: phoneControelr.text,
                                          bio: bioControelr.text,
                                          email: emailControelr.text);
                                    } else if (cubit.coverimage == null &&
                                        cubit.profileimage != null) {
                                      cubit.updateProfileImage(
                                          name: nameControelr.text,
                                          phone: phoneControelr.text,
                                          bio: bioControelr.text,
                                          email: emailControelr.text);
                                    } else if (cubit.coverimage != null &&
                                        cubit.profileimage != null) {
                                      cubit.uploadbothimage(
                                          name: nameControelr.text,
                                          phone: phoneControelr.text,
                                          bio: bioControelr.text,
                                          email: emailControelr.text);
                                    } else if (cubit.coverimage == null &&
                                        cubit.profileimage == null) {
                                      cubit.updatauserdatat(
                                          name: nameControelr.text,
                                          phone: phoneControelr.text,
                                          bio: bioControelr.text,
                                          email: emailControelr.text);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          nameControelr.text == '' &&
                                                  bioControelr.text == '' &&
                                                  phoneControelr.text == '' &&
                                                  emailControelr.text == ''
                                              ? Colors.grey
                                              : Colors.blue),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: const Text('Update'),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          padding: EdgeInsets.zero,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.265,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                          ),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: coverimage == null
                                                  ? NetworkImage(
                                                      '${usermodel?.cover}')
                                                  : FileImage(coverimage)
                                                      as ImageProvider)),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        SocialappCubit.get(context)
                                            .getcpverimage();
                                      },
                                      icon: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.grayshade,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 85,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 80,
                                      backgroundImage: profileimage == null
                                          ? NetworkImage('${usermodel?.image}')
                                          : FileImage(profileimage)
                                              as ImageProvider,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      SocialappCubit.get(context)
                                          .getprofileimage();
                                    },
                                    icon: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.grayshade,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: TextFormField(
                            //  autofocus: false,
                            //enabled: true,

                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Name must not be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.onchangestate();
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade800,
                                filled: cubit.isdark == true ? true : false,
                                prefixIcon: Icon(
                                  IconBroken.user,
                                  color: cubit.isdark == false
                                      ? Colors.black
                                      : Colors.white,
                                )),
                            controller: nameControelr,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' bio must not be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.onchangestate();
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade800,
                                filled: cubit.isdark == true ? true : false,
                                prefixIcon: Icon(
                                  IconBroken.infocircle,
                                  color: cubit.isdark == false
                                      ? Colors.black
                                      : Colors.white,
                                )),
                            controller: bioControelr,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' phone must not be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.onchangestate();
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade800,
                              filled: cubit.isdark == true ? true : false,
                              prefixIcon: Icon(
                                IconBroken.call,
                                color: cubit.isdark == false
                                    ? Colors.black
                                    : Colors.white,
                              )),
                          controller: phoneControelr,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' email must not be empty';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              cubit.onchangestate();
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade800,
                                filled: cubit.isdark == true ? true : false,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: cubit.isdark == false
                                      ? Colors.black
                                      : Colors.white,
                                )),
                            controller: emailControelr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (cubit.isEditProfileLoading) loadinOnScreen(context)
          ],
        );
      },
    );
  }
}
