part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class SuccessRegisterState extends AuthState {}
class SuccessLoginState extends AuthState {}

class SuccessSentDataState extends AuthState {}
class SuccessGetDataState extends AuthState {}
