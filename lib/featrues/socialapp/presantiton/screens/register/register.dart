import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/core/constant/loading.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/emailvefirycation/fristsvrems.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/register/cubit/register_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/register/cubit/registerwith.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/castomtextfromfield.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/custombutton.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/customhedrs.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';

import '../../style/appcolor.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailControaelr = TextEditingController();
    var passwordControaelr = TextEditingController();
    var nameControaelr = TextEditingController();
    var phoneControaelr = TextEditingController();
    final fromkey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
         
          if (state is RegisterCeratUserScsuflly) {
            navigtonto(
                context,
                FristScreens(
                  image: RegisterCubit.get(context).imagefrist!,
                  uid: state.uid,
                ));
          }
          if(state is RegisterError)
          {
             showSnackBar(context: context, text:state.error.toString(), isError: true);
          }
          if(state is RegisterCeratUserError)
          {
            showSnackBar(context: context, text: state.error.toString(), isError: true);
          }
        }, builder: (context, state) {
          // var cubit = SocialappCubit.get(context);
          SystemUiOverlayStyle value = SystemUiOverlayStyle.light
              .copyWith(statusBarColor: AppColors.blue);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! RegisterLoading,
            widgetBuilder: (context) => AnnotatedRegion(
              value: value,
              child: SafeArea(
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
                            text: 'Sign Up.',
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
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09),
                                          child:
                                              Image.asset(AppImageAssets.login),
                                        ),
                                        castomfromfield(
                                          context,
                                          controller: nameControaelr,
                                          hedlinetext: 'Username',
                                          hinttext: 'Username',
                                          type: TextInputType.name,
                                          vildate: (String value) {
                                            if (value.isEmpty) {
                                              return 'failed is requerd';
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        castomfromfield(
                                          context,
                                          controller: emailControaelr,
                                          hedlinetext: 'E-mail',
                                          hinttext: 'example@gmail.com',
                                          type: TextInputType.emailAddress,
                                          vildate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Email Must Not Empty';
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        castomfromfield(context,
                                            controller: passwordControaelr,
                                            hedlinetext: 'Password',
                                            hinttext: 'at least 8 charactres',
                                            type: TextInputType.visiblePassword,
                                            vildate: (String value) {
                                              if (value.isEmpty) {
                                                return 'Password Must Not Empty';
                                              }
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            suffixicon:
                                                RegisterCubit.get(context).icon,
                                            onpressedicon: () {
                                              RegisterCubit.get(context)
                                                  .changeicon();
                                            },
                                            isscure: RegisterCubit.get(context)
                                                .iconshow,
                                            maxlines: 1),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        castomfromfield(
                                          context,
                                          controller: phoneControaelr,
                                          hedlinetext: 'Phone',
                                          hinttext: '+20-10-xxxx-xxxx',
                                          type: TextInputType.phone,
                                          vildate: (String value) {
                                            if (value.isEmpty) {
                                              return 'failed is requerd';
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 25),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 140,
                                                height: 50,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      navigtonto(
                                                          context,
                                                          const RegisterWith(
                                                            name: 'Facebook',
                                                            isfacebook: true,
                                                            isgoogle: false,
                                                          ));
                                                      // RegisterCubit.get(context)
                                                      //     .singinwithfacebook();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      foregroundColor:
                                                          Colors.blue,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                    ),
                                                    child: Row(
                                                      children: const [
                                                        CircleAvatar(
                                                          radius: 15,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  AppImageAssets
                                                                      .facebook),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: Text(
                                                            'Facebook',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .blue),
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: SizedBox(
                                                  width: 155,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        navigtonto(
                                                            context, const RegisterWith(
                                                              name: 'Google', isfacebook: false, isgoogle: true));
                                                        // RegisterCubit.get(
                                                        //         context)
                                                        //     .singinwithgoogle();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        foregroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                255,
                                                                100,
                                                                73),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 5),
                                                      ),
                                                      child: Row(
                                                        children: const [
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors.white,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    AppImageAssets
                                                                        .google),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Text(
                                                              'Google',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          100,
                                                                          73)),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: castomButton(
                                              text: 'Register',
                                              onPressed: () {
                                                if (fromkey.currentState!
                                                    .validate()) {
                                                  return RegisterCubit.get(
                                                          context)
                                                      .userregister(
                                                        context: context,
                                                          name: nameControaelr
                                                              .text,
                                                          phone: phoneControaelr
                                                              .text,
                                                          email: emailControaelr
                                                              .text,
                                                          password:
                                                              passwordControaelr
                                                                  .text);
                                                }
                                              },
                                              color: AppColors.blue,
                                              width: double.infinity,
                                              raduis: 2,
                                              height: 40,
                                              isUpaercase: true),
                                        )
                                      ]))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            fallbackBuilder: (context) {
              return loading(context);
            },
          );
        }));
  }
}
