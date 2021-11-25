part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {
  SignUpInitial(this.obscureText, this.allowEmail);

  final bool obscureText;
  final bool allowEmail;
}
class SignUpShowPopUpLoading extends SignUpState {}
class SignUpDismissPopUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {}
class SignUpFail extends SignUpState {
  SignUpFail(this.message);

  final String message;
}
