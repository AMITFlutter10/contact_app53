import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app53/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context)=> BlocProvider.of(context);

 final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel user =UserModel();
  final FirebaseFirestore store = FirebaseFirestore.instance;
 registerByEmailAndPassword({String? name,required String email,
   required String password})
     async{
 UserCredential userCredential=   await auth.createUserWithEmailAndPassword(
     email: email, password: password);
  emit(SuccessRegisterState());
  user.name =name;
  user.email= email;
  user.password= password;
  // user.pic
  user.id = userCredential.user!.uid ;
  store.collection("user_profile").doc( user.id ).set(user.toMap());
  emit(SuccessSentDataState());

 }


 loginByEmailAndPassword({required String email,required String password})async{
 UserCredential useResult=  await auth.signInWithEmailAndPassword(email: email, password: password);
   emit(SuccessLoginState());
   var dataUser;
    dataUser = await store.collection("user_profile")
        .doc(useResult.user!.uid).get();
    user = UserModel.fromMap(dataUser.data);
    emit(SuccessGetDataState());
 }
}
