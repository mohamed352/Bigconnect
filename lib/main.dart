import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/config/endpoints.dart';
import 'package:socialapp/featrues/socialapp/presantiton/cubit/socialapp_cubit.dart';
import 'package:socialapp/layout/home/social.dart';
import 'blocopserver.dart';
import 'cashehelper.dart';
import 'featrues/socialapp/presantiton/screens/splach/presatoitons/splachview.dart';
import 'featrues/socialapp/presantiton/style/themapp.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(onbackgroundmassging);
  Widget widget;
  uidforall = CacheHelper.getData(key: 'uid');
  token = CacheHelper.getData(key: 'token');
  bool? darkmode = CacheHelper.getData(key: 'darkmode');
  debugPrint('token is $uidforall');

  if (uidforall != null) {
    widget = const SocialScreen();
  } else {
    widget = const Splach_View();
  }
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    startwidget: widget,
    darkmode: darkmode,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final Widget? startwidget;
  final bool? darkmode;

  const MyApp({super.key, this.startwidget, this.darkmode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
               SocialappCubit()
                ..getuserdata()
                ..getposts()
                ..getnotifications()
                ..gettoken()
                ..getstoryes()
                ..changedarkmood(fromshared: darkmode)),
        ],
        child: BlocConsumer<SocialappCubit, SocialappState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return MaterialApp(
              theme: themlight,
              darkTheme: themdark,
              themeMode: SocialappCubit.get(context).isdark! == false
                  ? ThemeMode.light
                  : ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              home: startwidget,

            );
          },
        ));
  }
}

Future<void> onbackgroundmassging(RemoteMessage message) async {}
