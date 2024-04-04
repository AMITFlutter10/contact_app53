

import 'package:contact_app53/Routes/route.dart';
import 'package:contact_app53/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/account/login_page.dart';
import '../view/account/register_page.dart';
import '../view/splash_page.dart';


Route<dynamic>?  onGenerate(RouteSettings settings){
  switch(settings.name){
    case AppRoute.register :
     return MaterialPageRoute(builder: (context)=> const RegisterScreen());

    case AppRoute.login:
          return MaterialPageRoute(builder: (context)=>  LoginScreen());
  // case AppRoute.home:
  //         return MaterialPageRoute(builder: (context)=> const HomeScreen());

    // default:
    //   return MaterialPageRoute(builder: (context)=> const RegisterPage());
  }

}