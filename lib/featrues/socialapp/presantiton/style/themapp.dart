import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/featrues/socialapp/presantiton/style/appcolor.dart';

ThemeData themlight = ThemeData(
  iconTheme: IconThemeData(color: Colors.black.withOpacity(0.4)),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 20,
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  primaryColor: AppColors.blue,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: Colors.white,
    elevation: 0,
  ),
);
ThemeData themdark = ThemeData(
  
  iconTheme: IconThemeData(color: Colors.grey.shade300),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.dark,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 20,
  ),
  cardTheme: CardTheme(
      color: AppColors.dark, clipBehavior: Clip.antiAliasWithSaveLayer),
  primaryColor: AppColors.blue,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  scaffoldBackgroundColor: AppColors.dark,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.grey.shade300),
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    color: AppColors.dark,
    elevation: 0,
  ),
);
SystemUiOverlayStyle valuedark = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppColors.dark,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light);
SystemUiOverlayStyle valuelight =
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white);
