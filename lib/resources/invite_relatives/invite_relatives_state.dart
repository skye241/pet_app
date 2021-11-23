part of 'invite_relatives_cubit.dart';

@immutable
abstract class InviteRelativesState {}

class InviteRelativesInitial extends InviteRelativesState {}
class InviteRelativesLoaded extends InviteRelativesState {
  InviteRelativesLoaded(this.media, this.permission, this.url);

  final Media media;
  final String permission;
  final String url;
}

class InviteRelativesStateFailed extends InviteRelativesState{}

class InviteRelativesStateShowPopUpLoading extends InviteRelativesState{}

class InviteRelativesStateDismissPopUpLoading extends InviteRelativesState {}

class InviteRelativesStateShowMessage extends InviteRelativesState {
  InviteRelativesStateShowMessage(this.message);

  final String message;
}