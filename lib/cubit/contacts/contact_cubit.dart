import 'package:bloc/bloc.dart';
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
  insertData({required String name,required String number , }){
    int uniqueId = DateTime.now().millisecondsSinceEpoch;
    fireStore.collection("Contacts").doc(uniqueId.toString()).set({
      "name":name,
      "number": number,
      "id": uniqueId,
      "type": "all"
    }).then((value) {
      emit(ContactSentSuccessDataState());
    }).catchError((error){
      print(ContactErrorDataState());
    });
  }
  // getData
   List<Map>contactList= [
   ];
   List<Map>favoriteList= [];
  getContacts()async{
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
   emit( LoadingGetFavoriteDataState());
    await fireStore.collection("Contacts").get().then((value) {
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
      //getContacts();
     emit(UpdateContactsDataState());
    });
  }
  updateFavorite({required String type, required int id }){
    fireStore.collection("Contacts").doc(id.toString()).update({
      "type":type,
    }).then((value) {
      getFavorite();
     emit(UpdateFavoriteDataState());
    });
  }

  deleteContact({required int id}){
    fireStore.collection("Contacts").doc(id.toString()).delete().then((value) {
      emit(DeleteContactsDataState());
      getContacts();
});

  }
}

