

import 'package:contact_app53/Routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/auth/register_page.dart';
import '../view/splash_page.dart';


Route<dynamic>?  onGenerate(RouteSettings settings){
  switch(settings.name){
    case AppRoute.splash :
     { return MaterialPageRoute(builder: (context)=> const SplashPage()); }
    case AppRoute.register:
         { MaterialPageRoute(builder: (context)=> const RegisterPage());}
  }

}