part of 'register_fast_cubit.dart';

@immutable
abstract class RegisterFastState {}

class RegisterFastInitial extends RegisterFastState {}

class RegisterFastStatePopUpLoading extends RegisterFastState {}

class RegisterFastStateDismissPopUpLoading extends RegisterFastState {}

class RegisterFastStateSuccess extends RegisterFastState {
  // RegisterFastStateSuccess(this.user);
  //
  // final User? user;
}

class RegisterFastStateFail extends RegisterFastState {
  RegisterFastStateFail(this.message);

  final String message;
}
