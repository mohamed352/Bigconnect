import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/data/models/userdata.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool iconshow = true;
  IconData icon = Icons.remove_red_eye_outlined;
  void changeicon() {
    emit(RegisterInitial());
    iconshow = !iconshow;
    icon = iconshow
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangeIcon());
  }

  String? imagefrist;

  Future<void> userregister({
    required context,
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      var value = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ceartdatauser(
          context: context,
          email: email,
          name: name,
          uid: value.user!.uid,
          phone: phone);
    } catch (error) {
     
      emit(RegisterError(error.toString()));
    }
  }

  Future<void> ceartdatauser({
    required context,
    required String name,
    String? phone,
    required String email,
    required String uid,
    String? image,
  }) async {
    
    try {
      imagefrist = image ??
          'https://img.freepik.com/free-vector/cute-astronaut-listening-music-boombox-cartoon-vector-icon-illustration-science-music-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-4248.jpg?w=740&t=st=1663877945~exp=1663878545~hmac=fdb6d3cd5c6c5162639f8f68460c189d3a83113172c8135a3c97ce72ccb72026';
      UserData model = UserData(
        name: name,
        email: email,
        phone: phone,
        token: token,
        uid: uid,
        time: DateTime.now(),
        friends: [uid],
        bio: 'write your bio ....',
        isEmailferivied: FirebaseAuth.instance.currentUser!.emailVerified,
        cover:
            'https://img.freepik.com/free-vector/flat-abstract-music-youtube-thumbnail_23-2148912305.jpg?w=826&t=st=1663877840~exp=1663878440~hmac=88d73960b5260119530893b8203d7a4235316adc73715e346a837bccbd641be8',
        image: image ??
            'https://img.freepik.com/free-vector/cute-astronaut-listening-music-boombox-cartoon-vector-icon-illustration-science-music-icon-concept-isolated-premium-vector-flat-cartoon-style_138676-4248.jpg?w=740&t=st=1663877945~exp=1663878545~hmac=fdb6d3cd5c6c5162639f8f68460c189d3a83113172c8135a3c97ce72ccb72026',
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(model.tomap());

      emit(RegisterCeratUserScsuflly(uid));
    } catch (error) {
      
      emit(RegisterCeratUserError(error.toString()));
    }
  }

  Future<void> singinwithgoogle(String password, context) async {
    emit(RegisterLoading());
    try {
       GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      

      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: googleUser!.email, password: password);

      ceartdatauser(
          context: context,
          email: googleUser.email,
          name: googleUser.displayName!,
          image: googleUser.photoUrl,
          uid: value.user!.uid,
          phone: value.user!.phoneNumber);
    } catch (error) {
     
      emit(RegisterError(error.toString()));
    }
  }

  Future<void> singinwithfacebook(String password, context) async {
    emit(RegisterLoading());
    try{
    await FacebookAuth.instance.login();
    final userData = await FacebookAuth.instance.getUserData();

    var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData['email'], password: password);
    ceartdatauser(
        context: context,
        name: userData['name'],
        phone: value.user!.phoneNumber,
        email: userData['email'],
        image: userData['picture']['data']['url'],
        uid: value.user!.uid);
    } catch (error) {
      
      emit(RegisterError(error.toString()));
    }
  }
}
