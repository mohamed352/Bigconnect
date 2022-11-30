import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:socialapp/cashehelper.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/profiels/profile.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/serach/serach.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/splach/presatoitons/splachview.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/themapp.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/animationsroutes.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialappCubit, SocialappState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialappCubit.get(context);
        return AnnotatedRegion(
          value: cubit.isdark == true ? valuedark : valuelight,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              size: 30,
                            )),
                        Container(
                          height: 35,
                          padding: EdgeInsets.zero,
                          margin: const EdgeInsets.only(top: 6),
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width * 0.82,

                          child: TextFormField(
                            onTap: () {
                              Navigator.of(context)
                                  .push(SlideRight(page: const SearchScreen()));
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 0.7),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20,
                                color: cubit.isdark == false
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              fillColor: cubit.isdark == false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: cubit.isdark == false
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(
                            'Control preferences for this profile',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(SlideRight(
                            page: ProfileScreen(otheruid: uidforall)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (cubit.usermodel?.image != null)
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(cubit.usermodel!.image!),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Profile settings',
                                ),
                                Text(
                                  'For ${cubit.usermodel?.name}',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: cubit.isdark == false
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(
                            'Mange settings realted to permissions,darkmode delet account and others settings ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LiteRollingSwitch(
                        value: cubit.isdark!,
                        onChanged: (value) => cubit.changedarkmood(),
                        iconOn: Icons.light_mode,
                        iconOff: Icons.dark_mode,
                        textOn: 'Lightmode',
                        textOff: 'Darkmode',
                        width: 135,
                        colorOff: Colors.grey.shade800,
                        colorOn: Colors.amber,

                        // animationDuration: const Duration(milliseconds: 300),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: cubit.isdark == false
                                  ? Colors.white
                                  : AppColors.dark,
                              title: const Text('Socialapp'),
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    const Text(
                                        'Are you sure you want to delet the account?'),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 11),
                                            child: SizedBox(
                                              width: 90,
                                              height: 30,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    cubit.deletMuAccount(
                                                        context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30))),
                                                  child: const Text('Yes')),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 90,
                                            height: 30,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: const Text('No')),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.delete_forever,
                              size: 50,
                            ),
                            Text(
                              'Delet my account ',
                              style: TextStyle(fontSize: 16, height: 2.5),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                          child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              cubit.clearpostphoto();
                              FacebookAuth.instance.logOut();
                              GoogleSignIn().signOut();
                              CacheHelper.removedatae(key: 'uid');

                              navigtonandfinish(context, const Splach_View());
                              cubit.currentindex = 0;
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                enableFeedback: true,
                                shadowColor: Colors.black,
                                backgroundColor: cubit.isdark == false
                                    ? Colors.grey.shade300
                                    : Colors.black.withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: cubit.isdark == false
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
