part of 'edit_account_cubit.dart';

@immutable
abstract class EditAccountState {}

class EditAccountInitial extends EditAccountState {
  EditAccountInitial(this.avatar);

  final File? avatar;
}

class EditAccountStateShowPopUpLoading extends EditAccountState{}

class EditAccountStateDismissPopUpLoading extends EditAccountState{}

class EditAccountStateSuccess extends EditAccountState{}

class EditAccountStateFail extends EditAccountState {
  EditAccountStateFail(this.message);

  final String message;
}