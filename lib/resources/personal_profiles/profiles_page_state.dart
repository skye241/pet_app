part of 'profiles_page_cubit.dart';

@immutable
abstract class ProfilesPageState {}

class ProfilesPageInitial extends ProfilesPageState {}

class ProfilesShowPopUpLoading extends ProfilesPageState {}
class ProfilesPageDismissLoading extends ProfilesPageState {}

class ProfilesPageStateLoaded extends ProfilesPageState {
  ProfilesPageStateLoaded(
      this.familyList, this.friendList, this.user, this.listPets);

  final List<UserInfo> familyList;
  final List<UserInfo> friendList;
  final UserInfo user;
  final List<Pet> listPets;
  // final bool allowNotification;
}
class ProfilesPageSuccess extends ProfilesPageState {}
class ProfilesPageFailed extends ProfilesPageState {
  ProfilesPageFailed(this.message);

  final String message;
}
