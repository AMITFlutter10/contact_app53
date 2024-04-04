import 'package:contact_app53/Routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../widgets/default_form_field.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
 double h = MediaQuery.of(context).size.height ;
 double w = MediaQuery.of(context).size.width ;
    return  Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            height: h * 0.60,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.pink.withOpacity(.5),
                                    blurRadius: 7,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 3)),
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(130),
                                topRight: Radius.circular(150),
                              ),
                            ),
                          ),
                          const  Padding(
                            padding:  EdgeInsets.only(top: 25, left: 10),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  // color: AppTheme.third
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 120, left: 80),
                            child: Container(
                              height: 40.h,
                              width: 90.w,
                              decoration: const BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(.5),
                                //     blurRadius: 7,
                                //     spreadRadius: 5,
                                //     offset: Offset(0,3)
                                //   ),
                                // ],
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(130),
                                    topRight: Radius.circular(90)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 25, right: 25),
                                child: Column(
                                  children: [
                                    DefaultFormField(
                                        radius: 25,
                                        controller: emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        labelText: "Email",
                                        validator: (value) {
                                          if (value!.length == 0) {
                                            return "Email Can not be empty ";
                                          }
                                          if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z-9+_.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return " please enter valid email";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DefaultFormField(
                                        controller: passwordController,
                                        labelText: "Password",
                                        keyboardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.length <= 6) {
                                            return "password should be return 6";
                                          }
                                          return null;
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: w * 0.3,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if(formKey.currentState!.validate()){
                                            AuthCubit.get(context).loginByEmailAndPassword(
                                                email: emailController.text,
                                                password: passwordController.text);
                                            await  Navigator.of(context).pushNamedAndRemoveUntil( AppRoute.home, (route) => false);

                                          }},
                                        style: ElevatedButton.styleFrom(
                                          // primary: kPrimaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(20))),
                                        child:const  Text("Login"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(" Create new account ?"),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed("RegisterScreen");
                                },
                                child:const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      // color: AppTheme.kPrimaryColor),
                                ),
                              ),
                              )],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

  }
}