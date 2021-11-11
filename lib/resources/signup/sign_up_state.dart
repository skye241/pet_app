part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {
  SignUpInitial(this.showPassword);

  final bool showPassword;
}
class SignUpShowPopUpLoading extends SignUpState {}
class SignUpDismissPopUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {}
class SignUpFail extends SignUpState {
  SignUpFail(this.message);

  final String message;
}
