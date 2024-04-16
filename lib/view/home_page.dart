import 'package:contact_app53/cubit/contacts/contact_cubit.dart';
import 'package:contact_app53/cubit/theme/theme_cubit.dart';
import 'package:contact_app53/utilities/styles/color.dart';
import 'package:contact_app53/view/widgets/default_form_field.dart';
import 'package:contact_app53/view/widgets/default_phone_form.dart';
import 'package:contact_app53/view/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../utilities/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state is ContactSentSuccessDataState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            actions: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Switch(
                    value: ThemeCubit.get(context).isDark,
                    onChanged: (value) {
                      ThemeCubit.get(context).changeTheme();
                    },
                    activeColor: AppTheme.kContentColorLightTheme,
                    inactiveThumbColor: Colors.amber,
                  );
                },
              )
            ],
          ),
          key: scaffoldKey,
          body: Stack(
            children: [
              // Container(
              //   decoration:  BoxDecoration(
              //       gradient: LinearGradient(
              //           begin: AlignmentDirectional.centerStart,
              //           end: AlignmentDirectional.bottomEnd,
              //           colors: [Colors.pinkAccent, Colors.purpleAccent, Colors.grey]
              //       )
              //   ),
              // ),
              BlocBuilder<ContactCubit, ContactState>(
                builder: (BuildContext context, state) {
                  if (state is LoadingGetDataState ||
                      state is LoadingGetFavoriteDataState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ErrorWhenGetDataState ||
                      state is ErrorWhenGetFavoriteDataState) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 60.sp,
                          ),
                          DefaultText(
                            text: "Error",
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ContactCubit.get(context)
                        .screen[ContactCubit.get(context).currentIndex];
                  }
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () async {
              if (ContactCubit.get(context).isBottomSheetShow) {
                if (formKey.currentState!.validate()) {
                  await ContactCubit.get(context).insertData(
                      name: nameController.text,
                      number: "${myCountry.dialCode}${phoneController.text}");
                }
              } else {
                ContactCubit.get(context).changeBottomSheet(
                    isShown: true, icon: Icons.add_box_outlined);
                scaffoldKey.currentState!
                    .showBottomSheet((context) => Wrap(children: [
                          Container(
                            color: Colors.pinkAccent,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.w),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Name Cant be empty ";
                                      }
                                      return null;
                                    },
                                    textColor: Colors.white,
                                    prefixIcon: Icon(Icons.title),
                                    hintText: "Contacts Name",
                                  ),
                                  DefaultPhoneFormField(
                                    controller: phoneController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "phone number must not be empty ";
                                      }
                                      return null;
                                    },
                                    label: "Phone Number",
                                    textColor: Colors.white,
                                    onChange: (countryCode) {
                                      myCountry = countryCode;
                                    },
                                    hintText: "Contact Phone Number",
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]))
                    .closed
                    .then((value) => ContactCubit.get(context)
                        .changeBottomSheet(
                            isShown: false, icon: Icons.person_add));
              }
            },
            elevation: 20,
            child: Icon(ContactCubit.get(context).floatingIcon),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            notchMargin: 13,
            child: BottomNavigationBar(
              selectedFontSize: 5.sp,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              // selectedItemColor: AppTheme.primaryColor,
              // unselectedItemColor: AppTheme.white,
              elevation: 0,
              currentIndex: ContactCubit.get(context).currentIndex,
              onTap: (index) =>
                  ContactCubit.get(context).changeButtonNavbar(index),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.contacts_outlined),
                  label: ContactCubit.get(context).title[0],
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: ContactCubit.get(context).title[1],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
