// import 'package:contact_app53/cubit/contacts/contact_cubit.dart';
// import 'package:contact_app53/view/widgets/default_phone_form.dart';
// import 'package:contact_app53/view/widgets/default_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   // }
//   // late HomeCubit cubit;
//   //
//   // @override
//   // void didChangeDependencies() {
//   //   cubit = HomeCubit.get(context);
//   //   super.didChangeDependencies();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ContactCubit, ContactState>(
//       listener: (context , state) {
//         // if(state is AppInsertContactsState){
//         //   Navigator.pop(context);
//         // }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           extendBody: true,
//          // key: scaffoldKey,
//           appBar: AppBar(
//             centerTitle: true,
//           //  backgroundColor: AppTheme.primaryColor,
//             title: DefaultText(
//               text:"",
//               // text: cubit.appBarTitles[cubit.currentIndex],
//               // textColor: AppTheme.white,
//               // weight: FontWeight.bold,
//
//             ),
//           ),
//           body: Stack(
//             children: [
//               Container(
//                 decoration:  BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: AlignmentDirectional.centerStart,
//                         end: AlignmentDirectional.bottomEnd,
//             colors: [],
//                      //   colors: [AppTheme.primaryColor, AppTheme.secondColor2, AppTheme.gray]
//                     )
//                 ),
//               ),
//               BlocBuilder<ContactCubit, ContactState>(
//                 builder: (BuildContext context, state){
//                   // if(state is AppGetContactsLoadingState || state is AppGetFavoritesLoadingState ){
//                   //   return const Center(child:  CircularProgressIndicator(),);
//                   // } else if( state is AppGetContactsErrorState || state is AppGetFavoritesErrorState){
//                     return Center(
//                       child:  Column(
//                         children: [
//                           Icon(
//                             Icons.error,
//                             color: Colors.red,
//                             size: 60.sp,
//                           ),
//                           DefaultText(text: "Error",
//                             textColor: AppTheme.white,
//                             textSize: 20.sp,
//                             weight: FontWeight.bold,
//                           )
//                         ],
//                       ),
//                     );
//                   }else{
//                     return cubit.screens[cubit.currentIndex];
//                   }
//                 },
//               )
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             shape: const CircleBorder(),
//             onPressed: () async{
//               if (cubit.isBottomSheetShow) {
//                 if (formKey.currentState!.validate()) {
//                   await cubit.insertContact(name: nameController.text,
//                       phoneNumber:"${myCountry.dialCode}${phoneController.text}");
//                 }
//               } else {
//                 cubit.changeBottomSheet(
//                     isShown: true, icon: Icons.add_box_outlined);
//                 scaffoldKey.currentState!
//                     .showBottomSheet((context) => Wrap(
//                     children:[
//                       Container(
//                         color: AppTheme.secondColor,
//                         padding: EdgeInsets.symmetric(
//                             vertical: 2.h, horizontal: 3.w),
//                         child: Form(
//                           key: formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               DefaultFormField(
//                                 controller: nameController,
//                                 keyboardType: TextInputType.name,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Name Cant be empty ";
//                                   }
//                                   return null;
//                                 },
//                                 textColor: AppTheme.white,
//                                 prefixIcon: Icon(Icons.title),
//                                 hintText: "Contacts Name",
//                               ),
//                               DefaultPhoneFormField(
//                                 controller: phoneController,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "phone number must not be empty ";
//                                   }
//                                   return null;
//                                 },
//                                 label: "Phone Number",
//                                 textColor: AppTheme.white,
//                                 onChange: (countryCode) {
//                                   myCountry = countryCode;
//                                 },
//                                 hintText: "Contact Phone Number",
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]))
//                     .closed
//                     .then((value) => cubit.changeBottomSheet(
//                     isShown: false, icon: Icons.person_add));
//               }
//             },
//             child: Icon(cubit.floatingIcon),
//             elevation: 20,
//
//           ),
//           floatingActionButtonLocation:
//           FloatingActionButtonLocation.centerDocked,
//           bottomNavigationBar: BottomAppBar(
//             color: Colors.transparent,
//             elevation: 0,
//             shape: const CircularNotchedRectangle(),
//             notchMargin:13,
//             child: BottomNavigationBar(
//               selectedFontSize: 10.sp,
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: Colors.transparent,
//               selectedItemColor: AppTheme.primaryColor,
//               unselectedItemColor: AppTheme.white,
//               elevation: 0,
//               currentIndex: cubit.currentIndex,
//               onTap: (index) => cubit.changeScreensIndex(index),
//               items: [
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.contacts_outlined),
//                   label: cubit.appBarTitles[0],
//                 ),
//                 BottomNavigationBarItem(
//                   icon: const Icon(Icons.favorite),
//                   label: cubit.appBarTitles[1],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
