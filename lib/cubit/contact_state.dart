part of 'contact_cubit.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}
class ContactSentSuccessDataState extends ContactState {}
class ContactErrorDataState extends ContactState {}
