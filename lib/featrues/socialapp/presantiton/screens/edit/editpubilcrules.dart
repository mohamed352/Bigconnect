import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';

import '../../../../../config/endpoints.dart';

class EditPubilcRules extends StatelessWidget {
  final homeControelr = TextEditingController();
  final socialsituationControelr = TextEditingController();
  final educationControelr = TextEditingController();
  EditPubilcRules({super.key});

  @override
  Widget build(BuildContext context) {
    final fromkey = GlobalKey<FormState>();
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        File? profileimage = SocialappCubit.get(context).profileimage;

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: fromkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                    ? NetworkImage('${cubit.usermodel?.image}')
                                    : FileImage(profileimage) as ImageProvider,
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
                                      uid: uidforall!,
                                      education: educationControelr.text,
                                      locaiton: homeControelr.text,
                                      socialsituation: socialsituationControelr.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: const Text('Done')),
                          ),
                        ),
                      )
                    ],
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
