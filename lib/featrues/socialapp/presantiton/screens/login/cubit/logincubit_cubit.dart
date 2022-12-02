import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cashehelper.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/featrues/socialapp/presantiton/widgets/navgations.dart';
import 'package:socialapp/layout/home/social.dart';

part 'logincubit_state.dart';

class LogincubitCubit extends Cubit<LogincubitState> {
  LogincubitCubit() : super(LogincubitInitial());
  static LogincubitCubit get(context) => BlocProvider.of(context);
  bool iconshow = true;
  IconData icon = Icons.remove_red_eye_outlined;
  void changeicon() {
    emit(LogincubitInitial());
    iconshow = !iconshow;
    icon = iconshow
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(LoginChangeIcon());
  }

  String? image;

  Future<void> userregister({
    context,
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      var value = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      image = value.user!.photoURL;
      uidforall = value.user!.uid;
      SocialappCubit.get(context).getuserdata(uid: value.user!.uid);
      SocialappCubit.get(context).getposts(uid1: value.user!.uid);
      SocialappCubit.get(context).getstoryes(uid1: value.user!.uid);
      SocialappCubit.get(context).getnotifications(uid1: value.user!.uid);
      SocialappCubit.get(context).gettoken(uid1: value.user!.uid);
      SocialappCubit.get(context).updatetoken(context, uid1: value.user!.uid);

      remmberme
          ? CacheHelper.savedata(key: 'uid', value: value.user!.uid)
          : null;
      navigtonandfinish(context, const SocialScreen());
      emit(LoginScsuflly(value.user!.uid));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  bool remmberme = false;
  void remmbermechange() {
    emit(LogincubitInitial());
    remmberme = !remmberme;
    emit(LoginRemmberMe());
  }

  Future<void> forgetpassord(String email, context) async {
    emit(LoginForgetPassordLoading());
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      emit(LoginForgetPassordDone());
    } catch (e) {
      emit(LoginForgetPassordError(e.toString()));
    }
  }
}
