part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInShowPopUpLoading extends SignInState {}
class SignInShowDismissPopUpLoading extends SignInState {}
class SignInStateSuccess extends SignInState{}
class SignInStateFail extends SignInState{
  SignInStateFail(this.message);

  final String message;
}