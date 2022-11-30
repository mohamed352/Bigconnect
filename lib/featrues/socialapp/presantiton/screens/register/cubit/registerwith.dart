import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/emailvefirycation/fristsvrems.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/register/cubit/register_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/castomtextfromfield.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/customhedrs.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

class RegisterWith extends StatelessWidget {
  final String name;
  final bool isgoogle;
  final bool isfacebook;
  const RegisterWith(
      {super.key,
      required this.name,
      required this.isfacebook,
      required this.isgoogle});

  @override
  Widget build(BuildContext context) {
    var passwordControaelr = TextEditingController();

    final fromkey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
          if (state is RegisterError) {
            showSnackBar(
                context: context, text: state.error.trim(), isError: true);
          }
          if (state is RegisterCeratUserScsuflly) {
            navigtonto(
                context,
                FristScreens(
                  image: RegisterCubit.get(context).imagefrist!,
                  uid: state.uid,
                ));
          }
        }, builder: (context, state) {
          SystemUiOverlayStyle value = SystemUiOverlayStyle.light
              .copyWith(statusBarColor: AppColors.blue);

          return AnnotatedRegion(
            value: value,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Form(
                      key: fromkey,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.blue,
                          ),
                          CustomHeders(
                            size: isfacebook == true ? 0 : 10,
                            sizemargin: isfacebook == true ? 5 : 10,
                            text: 'Register with $name ',
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Positioned(
                              top: MediaQuery.of(context).size.height * 0.08,
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.9,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      color: AppColors.whiteshade,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 250,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          margin: EdgeInsets.only(
                                              bottom: 10,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09),
                                          child:
                                              Image.asset(AppImageAssets.login),
                                        ),
                                        castomfromfield(
                                          context,
                                          controller: passwordControaelr,
                                          hedlinetext: 'Password',
                                          hinttext: 'at least 8 charactres',
                                          type: TextInputType.visiblePassword,
                                          vildate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Password Must Not Empty';
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 70),
                                          child: ElevatedButton.icon(
                                            icon: isgoogle == true
                                                ? const CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage: AssetImage(
                                                        AppImageAssets.google),
                                                  )
                                                : const CircleAvatar(
                                                    radius: 15,
                                                    backgroundImage: AssetImage(
                                                        AppImageAssets
                                                            .facebook),
                                                  ),
                                            label: Text(
                                              name,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: isgoogle == true
                                                      ? Colors.red
                                                      : Colors.blue),
                                            ),
                                            onPressed: () {
                                              if (fromkey.currentState!
                                                  .validate()) {
                                                isfacebook == true
                                                    ? RegisterCubit.get(context)
                                                        .singinwithfacebook(
                                                            passwordControaelr
                                                                .text,context)
                                                    : RegisterCubit.get(context)
                                                        .singinwithgoogle(
                                                            passwordControaelr
                                                                .text,context);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    isgoogle == true
                                                        ? Colors.red
                                                        : Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                minimumSize: const Size(
                                                    double.infinity, 45),
                                                backgroundColor: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
