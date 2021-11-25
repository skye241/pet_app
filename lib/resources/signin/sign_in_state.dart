part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {
  SignInInitial(this.showPassword);

  final bool showPassword;
}

class SignInShowPopUpLoading extends SignInState {}
class SignInShowDismissPopUpLoading extends SignInState {}
class SignInStateSuccess extends SignInState{}
class SignInStateFail extends SignInState{
  SignInStateFail(this.message);

  final String message;
}