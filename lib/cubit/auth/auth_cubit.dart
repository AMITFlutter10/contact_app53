
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app53/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context)=> BlocProvider.of(context);

 final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel userModel =UserModel();
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ImagePicker picker = ImagePicker();
   final FirebaseStorage storage = FirebaseStorage.instance;


  registerByEmailAndPassword({required String name,
    required String email ,
    required String password,
  })async{
    UserCredential userCredential =
    await  auth.createUserWithEmailAndPassword(email: email, password: password);
    //  userModel.pic
    userModel.email = email;
    userModel.id= userCredential.user!.uid;
    userModel.name = name;
    await store.collection("profile").doc(userModel.id).
    set(userModel.toMap()) ;
    emit(AuthRegisterByEmailState());
  }



  loginByEmailAndPassword({required String email,required String password})async{
 UserCredential useResult=  await auth.signInWithEmailAndPassword(email: email, password: password);
   emit(SuccessLoginState());
   var dataUser;
    dataUser = await store.collection("user_profile")
        .doc(useResult.user!.uid).get();
    userModel = UserModel.fromMap(dataUser.data);
    emit(SuccessGetDataState());
 }

  signInByGoogle()async{
    googleSignIn.signOut();
    //esraa.amit@gmail.com
    emit(AuthLoadingState());
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication = await
    googleSignInAccount!
        .authentication;
    AuthCredential userCredential =GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    var user= await auth.signInWithCredential(userCredential);
    userModel.id = user.user!.uid; //orpRW53##
    userModel.name = user.user!.displayName;
    userModel.pic =user.user!.photoURL;
    userModel.email = user.user!.email;
    await store.collection("users_profile").doc(userModel.id).set(userModel.toMap());

  }


  XFile? userImage;
  uploadImage(String camera)async{
    if(camera == "cam"){
      userImage= (await picker.pickImage(source: ImageSource.camera))!;
      await storage.ref().child('images/').child("${userModel.id} as camera")
          .putFile(File(userImage!.path));
      emit(SentPhotoState());
      return userImage?.readAsBytes();
    }
    else
    {
      userImage = (await picker.pickImage(source: ImageSource.gallery))!;
      await storage.ref().child('images/').child("${userModel.id}as gallery")
          .putFile(File(userImage!.path));
      emit(SentPhotoState());
      return userImage?.readAsBytes();
    }}

}
