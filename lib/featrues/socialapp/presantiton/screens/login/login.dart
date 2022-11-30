import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/core/constant/loading.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/castomtextfromfield.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/custombutton.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/customhedrs.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/forgetpaswoordscreen.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

import '../../style/appcolor.dart';
import '../../widgets/navgations.dart';
import '../register/register.dart';
import 'cubit/logincubit_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailControaelr = TextEditingController();
    var passwordControaelr = TextEditingController();
    final fromkey = GlobalKey<FormState>();

    return BlocProvider(
        create: (context) => LogincubitCubit(),
        child: BlocConsumer<LogincubitCubit, LogincubitState>(
            listener: (context, state) {
           
          if (state is LoginError) {
            showSnackBar(
                context: context, text: state.error.toString(), isError: true);
          }
          if (state is LoginForgetPassordError) {
            showSnackBar(
                context: context, text: state.error.toString(), isError: true);
          }
        }, builder: (context, state) {
        //  var cubit = SocialappCubit.get(context);
          SystemUiOverlayStyle value = SystemUiOverlayStyle.light
              .copyWith(statusBarColor: AppColors.blue);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => state is! LoginLoading,
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
                            text: 'Log In.',
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
                                        const SizedBox(
                                          height: 10,
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
                                        //const SizedBox(height: 4,),
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
                                                LogincubitCubit.get(context)
                                                    .icon,
                                            onpressedicon: () {
                                              LogincubitCubit.get(context)
                                                  .changeicon();
                                            },
                                            isscure:
                                                LogincubitCubit.get(context)
                                                    .iconshow,
                                            maxlines: 1),
                                        Row(
                                          children: [
                                            Checkbox(
                                                value:
                                                    LogincubitCubit.get(context)
                                                        .remmberme,
                                                onChanged: (check) {
                                                  LogincubitCubit.get(context)
                                                      .remmbermechange();
                                                }),
                                            const Text(
                                              'Rember me ',
                                              style: TextStyle(
                                                  color: AppColors.blue,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                navigtonto(context,
                                                    const FrogetPasswordScreen());
                                              },
                                              child: const Text(
                                                'Foregt Password ? ',
                                                style: TextStyle(
                                                    color: AppColors.blue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            )
                                          ],
                                        ),

                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: castomButton(
                                              text: 'Login',
                                              onPressed: () {
                                                if (fromkey.currentState!
                                                    .validate()) {
                                                  LogincubitCubit.get(context)
                                                      .userregister(
                                                          context: context,
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
                                              height: 40),
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Don\'t Have an account ? ',
                                              style: TextStyle(
                                                  color: Colors.lightBlue),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  navigtonto(context,
                                                      const RegisterScreen());
                                                },
                                                child: const Text('Register')),
                                          ],
                                        )
                                      ]))),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            fallbackBuilder: (context) => loading(context),
          );
        }));
  }
}
