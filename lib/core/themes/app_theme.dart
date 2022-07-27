import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

// const primaryColor = Color(0xff0fc874);
// const myWhite = Colors.white;
// const Color scaffoldColor = Color(0xffebf3f9);

ThemeData lightMode = ThemeData(
  fontFamily: 'Jannah',
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    toolbarHeight: 70.h,
    iconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    //color: Colors.white,
    elevation: 0.7,
    titleTextStyle: TextStyle(
      color: Colors.black.withOpacity(.9),
      fontSize: 23.sp,
      fontWeight:FontWeight.w600,
      letterSpacing: 2,
    ),
  ),

);
//---------------------------------------------------------------------------
ThemeData darkMode =ThemeData(
    fontFamily: 'Jannah',
  scaffoldBackgroundColor: HexColor('273746'),
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('273746'),
      toolbarHeight: 70.h,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('273746'),
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.7,
      titleTextStyle:  TextStyle(
        color: Colors.white.withOpacity(.9),
        fontSize: 23.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

);