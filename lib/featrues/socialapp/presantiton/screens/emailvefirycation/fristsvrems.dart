import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/login/login.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/themapp.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

// ignore: must_be_immutable
class FristScreens extends StatelessWidget {
  final String uid;
  final String image;

  final homeControelr = TextEditingController();
  final socialsituationControelr = TextEditingController();
  final educationControelr = TextEditingController();
  FristScreens({super.key, required this.uid, required this.image});

  @override
  Widget build(BuildContext context) {
    final fromkey = GlobalKey<FormState>();
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        File? profileimage = SocialappCubit.get(context).profileimage;

        return AnnotatedRegion(
          value: cubit.isdark == false ? valuelight : valuedark,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: fromkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (!FirebaseAuth.instance.currentUser!.emailVerified)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            // padding: const EdgeInsets.all(4),
                            color: Colors.red.withOpacity(0.4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 13),
                                  child: Text(
                                    'Verify your email to get all access',
                                    style: TextStyle(height: 2.5),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      cubit.sendemailverfiy(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(20, 25),
                                    ),
                                    child: const Text('Send'))
                              ],
                            ),
                          ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          padding: EdgeInsets.zero,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 85,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: profileimage == null
                                      ? NetworkImage(image)
                                      : FileImage(profileimage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialappCubit.get(context).getprofileimage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppColors.grayshade,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          //  autofocus: false,
                          //enabled: true,

                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Locaiton must not be empty';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                              filled: cubit.isdark == true ? true : false,
                              fillColor: Colors.grey.shade600,
                              labelText: 'Write your locaition',
                              labelStyle: TextStyle(
                                  color: cubit.isdark == true
                                      ? Colors.white
                                      : Colors.grey),
                              prefixIcon: Icon(
                                Icons.home,
                                color: cubit.isdark == true
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey.shade600,
                              )),
                          controller: homeControelr,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          //  autofocus: false,
                          //enabled: true,

                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must not be empty';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: cubit.isdark == true
                                      ? Colors.white
                                      : Colors.grey),
                              filled: cubit.isdark == true ? true : false,
                              fillColor: Colors.grey.shade600,

                              //  helperText: 'd',

                              labelText: 'Social situation',
                              prefixIcon: Icon(
                                Icons.favorite,
                                color: cubit.isdark == true
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey.shade600,
                              )),
                          controller: socialsituationControelr,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: cubit.isdark == true
                                      ? Colors.white
                                      : Colors.grey),
                              filled: cubit.isdark == true ? true : false,
                              fillColor: Colors.grey.shade600,
                              labelText: 'Write your school or univeristy',
                              prefixIcon: Icon(
                                Icons.school_rounded,
                                color: cubit.isdark == true
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey.shade600,
                              )),
                          controller: educationControelr,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 40),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: SizedBox(
                              width: 120,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (fromkey.currentState!.validate()) {
                                      cubit.updatepubilcrules(
                                        education: educationControelr.text,
                                        locaiton: homeControelr.text,
                                        uid: uid,
                                        socialsituation:
                                            socialsituationControelr.text,
                                      );
                                      showSnackBar(
                                          context: context,
                                          text: 'You can now login',
                                          );
                                      navigtonandfinish(
                                          context, const LoginScreen());
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: const Text('Next')),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
