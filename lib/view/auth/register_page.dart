import 'package:flutter/material.dart';

import '../../Routes/route.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            // home
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> SplashPage()));
            // on generate
            Navigator.pushNamed(context, AppRoute.splash);
          },child: Text("done"),),
        ],
      ),
    );
}}
