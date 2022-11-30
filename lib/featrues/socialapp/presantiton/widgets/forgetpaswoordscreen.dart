import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/core/constant/assets.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/login/cubit/logincubit_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/castomtextfromfield.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/customhedrs.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/myalertdialog.dart';

class FrogetPasswordScreen extends StatelessWidget {
  const FrogetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailControaelr = TextEditingController();

    final fromkey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context) => LogincubitCubit(),
        child: BlocConsumer<LogincubitCubit, LogincubitState>(
            listener: (context, state) {
          if (state is LoginForgetPassordDone) {
            emailControaelr.text = '';
            showSnackBar(
                context: context,
                text: 'Passowrd rest send in your mail',
                );
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
                            text: 'Forget passowrd.',
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 70),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                if (fromkey.currentState!
                                                    .validate()) {
                                                  LogincubitCubit.get(context)
                                                      .forgetpassord(
                                                    emailControaelr.text,
                                                    context,
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  minimumSize: const Size(
                                                      double.infinity, 45)),
                                              child: const Text(
                                                'Send',
                                                style: TextStyle(fontSize: 18),
                                              )),
                                        )
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
