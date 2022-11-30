

// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialapp/featrues/socialapp/presantiton/screens/splach/presatoitons/widgets/splachbbody.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';

// ignore: camel_case_types
class Splach_View extends StatefulWidget {
  const Splach_View({super.key});

  @override
  State<Splach_View> createState() => _Splach_ViewState();
}

// ignore: camel_case_types
class _Splach_ViewState extends State<Splach_View> {
  @override
  void initState() {
  
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.babyblue,
       systemOverlayStyle:   SystemUiOverlayStyle(
        statusBarColor: AppColors.babyblue,
        statusBarIconBrightness: Brightness.dark,
      ),
      ),
      backgroundColor: AppColors.babyblue,
      body:const Splach_Body() ,
    );
  }
}
