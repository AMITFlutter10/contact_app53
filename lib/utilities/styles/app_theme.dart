import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.dart';
class Themes{
  static ThemeData lightTheme =ThemeData(
    colorScheme:const  ColorScheme.light(
      primary: AppTheme.primaryColor,
      secondary:AppTheme.primaryColor,
    ),
    iconTheme: const IconThemeData(color: AppTheme.lightPurpleColor ),
    buttonTheme: const ButtonThemeData(
        buttonColor: AppTheme.lightPurpleColor
    ),
    scaffoldBackgroundColor: AppTheme.nearlyWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.secondColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppTheme.nearlyWhite,

      ),
    ),
    drawerTheme:const DrawerThemeData(
        backgroundColor: AppTheme.primaryColor),
    sliderTheme: const SliderThemeData(
      inactiveTickMarkColor: Colors.transparent,
      activeTickMarkColor: Colors.transparent,
    ),
    checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.black),
        fillColor: MaterialStateProperty.all(AppTheme.secondColor)
    ),
    toggleButtonsTheme:const ToggleButtonsThemeData(
        selectedBorderColor: Colors.transparent,
        borderColor: Colors.transparent,
        fillColor: Colors.transparent
    ),
  );

  static ThemeData darkTheme =ThemeData(
    colorScheme:const  ColorScheme.light(
      primary: AppTheme.secondColor,
      secondary:AppTheme.secondColor,
    ),
    iconTheme: const IconThemeData(color: AppTheme.black ),
    buttonTheme: const ButtonThemeData(
        buttonColor: AppTheme.black
    ),
    scaffoldBackgroundColor: AppTheme.gray,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.gray,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppTheme.nearlyWhite,
      ),
    ),
    drawerTheme:const DrawerThemeData(backgroundColor: AppTheme.primaryColor)
    ,
    sliderTheme: const SliderThemeData(
      inactiveTickMarkColor: Colors.transparent,
      activeTickMarkColor: Colors.transparent,
    ),
    checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.black),
        fillColor: MaterialStateProperty.all(AppTheme.secondColor)
    ),
    toggleButtonsTheme:const ToggleButtonsThemeData(
        selectedBorderColor: Colors.transparent,
        borderColor: Colors.transparent,
        fillColor: Colors.transparent
    ),
  );}