part of 'invitation_cubit.dart';

@immutable
abstract class InvitationState {}

class InvitationInitial extends InvitationState {}

class InvitationStateLoaded extends InvitationState {
  InvitationStateLoaded(this.media);

  final Media media;
}

class InvitationStateFail extends InvitationState {}

class InvitationStateShowPopUp extends InvitationState {}

class InvitationStateDismissPopUp extends InvitationState {}

class InvitationStateSuccessSetRela extends InvitationState {}

class InvitationStateFailSetRela extends InvitationState {}
