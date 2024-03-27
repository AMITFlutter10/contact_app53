import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'contact_state.dart';


class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  static  ContactCubit get (context)=> BlocProvider.of(context);

  final fireStore = FirebaseFirestore.instance;

  sendData({required String name,required String number}){
    fireStore.collection("Contact").add({
      "name":name,
      "number": number
    }).then((value) {
      print(value);
      emit(ContactSentSuccessDataState());
    }).catchError((error){
      print(ContactErrorDataState());
    });
  }
}

