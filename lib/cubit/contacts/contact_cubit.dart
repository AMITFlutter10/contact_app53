import 'package:bloc/bloc.dart';
import 'package:contact_app53/view/contact_screen.dart';
import 'package:contact_app53/view/favorite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'contact_state.dart';


class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  static  ContactCubit get (context)=> BlocProvider.of(context);

  final fireStore = FirebaseFirestore.instance;
  // crud

  // createDataBase
  // insertDataBase
  // updateData
  // delete

  createDataBase(){
    getContacts();
    getFavorite();
  }
  insertData({required String name,required String number , }){
    int uniqueId = DateTime.now().millisecondsSinceEpoch;
    fireStore.collection("Contacts").doc(uniqueId.toString()).set({
      "name":name,
      "number": number,
      "id": uniqueId,
      "type": "all"
    }).then((value) {
      getContacts();
      getFavorite();
      emit(ContactSentSuccessDataState());
    }).catchError((error){
      print(ContactErrorDataState());
    });
  }
  // getData
   List<Map>  contactList= [
   ];
   List<Map>favoriteList= [];
  getContacts()async{
    contactList.clear();
   emit( LoadingGetDataState());
    await fireStore.collection("Contacts").get().then((value) {
      for (QueryDocumentSnapshot<Map<String,dynamic>> element in  value.docs ){
        contactList.add(element.data());}
      emit( SuccessGetDataState());
    }).catchError((error){
      print(error);
      emit( ErrorWhenGetDataState());
    });
  }
  getFavorite()async{
    favoriteList= [];
   emit( LoadingGetFavoriteDataState());
    await fireStore.collection("Contacts").where("type", isEqualTo: "Favorite").get().then((value) {
      favoriteList= [];
      for (QueryDocumentSnapshot<Map<String,dynamic>> element in  value.docs ){
          favoriteList.add(element.data());}
      emit( SuccessGetFavoriteDataState());
    }).catchError((error){
      print(error);
      emit( ErrorWhenGetFavoriteDataState());
    });
  }
  updateContact({required String name,required String number ,required int id }){
    fireStore.collection("Contacts").doc(id.toString()).update({
      "name":name,
      "number":number,
    }).then((value) {
      getContacts();
      getFavorite();
     emit(UpdateContactsDataState());
    });
  }
  updateFavorite({required String type, required int id }){
    fireStore.collection("Contacts").doc(id.toString()).update({
      "type":type,
    }).then((value) {
      getFavorite();
      getContacts();
     emit(UpdateFavoriteDataState());
    });
  }

  deleteContact({required int id}){
    fireStore.collection("Contacts").doc(id.toString()).delete().then((value) {
      emit(DeleteContactsDataState());
      getContacts();
      getFavorite();
});

  }
  List<String>title=[
    "contact",
    "favorite"
  ];
  bool isBottomSheetShow = false;
  IconData floatingIcon = Icons.person;

  void changeBottomSheet({required bool isShown, required IconData icon}) {
    isBottomSheetShow = isShown;
    floatingIcon = icon;
    emit(AppChangeBottomSheetState());
  }
  List<Widget>screen=[
    ContactScreen(),
    FavoriteScreen(),
  ];
  int currentIndex = 0;

  void changeButtonNavbar(int index){
    currentIndex =index;
    emit(ChangeNavState());
  }



}

