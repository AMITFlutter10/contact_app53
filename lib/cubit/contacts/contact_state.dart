part of 'contact_cubit.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}
class ContactSentSuccessDataState extends ContactState {}
class ContactErrorDataState extends ContactState {}


class LoadingGetDataState extends ContactState{}
class SuccessGetDataState extends ContactState{}
class ErrorWhenGetDataState extends ContactState{}

class LoadingGetFavoriteDataState extends ContactState{}
class SuccessGetFavoriteDataState extends ContactState{}
class ErrorWhenGetFavoriteDataState extends ContactState{}

class UpdateContactsDataState extends ContactState{}
class UpdateFavoriteDataState extends ContactState{}


class DeleteContactsDataState extends ContactState{}

class ChangeNavState extends ContactState{}
class AppChangeBottomSheetState extends ContactState{}