import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/pet_repository.dart';
import 'package:family_pet/repository/relationship_repository.dart';
import 'package:family_pet/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

part 'profiles_page_state.dart';

class ProfilesPageCubit extends Cubit<ProfilesPageState> {
  ProfilesPageCubit() : super(ProfilesPageInitial());

  final UserRepository userRepository = UserRepository();
  final RelationshipRepository relationshipRepository =
      RelationshipRepository();
  final PetRepository petRepository = PetRepository();
  final List<Pet> defaultListPet = <Pet>[];
  final List<UserInfo> defaultListFamily = <UserInfo>[];
  final List<UserInfo> defaultListFriend = <UserInfo>[];
  UserInfo defaultUserInfo = UserInfo();
  bool authorized = false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initEvent() async {
    try {
      final NotificationSettings settings =
          await firebaseMessaging.requestPermission(
        sound: true,
        alert: true,
        badge: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        authorized = true;
      }
      final List<dynamic> response = await Future.wait<dynamic>(
        <Future<dynamic>>[
          petRepository.getListPet(),
          userRepository.viewUserById(),
          relationshipRepository.getRelationship(),
        ],
      );

      final List<Pet> listPet = response[0] as List<Pet>;
      final UserInfo userInfo = response[1] as UserInfo;
      final List<UserInfo> listAll = response[2] as List<UserInfo>;

      final List<UserInfo> listFamily = listAll
          .where((UserInfo userInfo) =>
              userInfo.relationType == PermissionPickMedia.family)
          .toList();
      final List<UserInfo> listFriend = listAll
          .where((UserInfo userInfo) =>
              userInfo.relationType == PermissionPickMedia.friend)
          .toList();
      defaultListPet.addAll(listPet);
      defaultListFamily.addAll(listFamily);
      defaultListFriend.addAll(listFriend);
      defaultUserInfo = userInfo;

      emit(ProfilesPageStateLoaded(listFamily, listFriend, userInfo, listPet));
    } on APIException catch (e) {
      emit(ProfilesPageFailed(e.message()));
    }
  }

  Future<void> requestPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      badge: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      authorized = true;
    } else
      authorized = false;
    emit(ProfilesPageStateLoaded(
        defaultListFamily, defaultListFriend, defaultUserInfo, defaultListPet));
  }

  Future<void> logOut() async {
    try {
      emit(ProfilesShowPopUpLoading());
      defaultUserInfo.status != AccountStatus.active
          ? await userRepository.deleteUser()
          : await userRepository.logout();
      for (final String key in prefs!.getKeys()) {
        if (key != Constant.language) {
          prefs!.remove(key);
        }
      }
      emit(ProfilesPageDismissLoading());
      emit(ProfilesPageSuccess());
    } on APIException catch (e) {
      emit(ProfilesPageDismissLoading());
      emit(ProfilesPageFailed(e.message()));
    }
  }

  Future<void> addPet(Pet pet) async {
    defaultListPet.add(pet);
    emit(ProfilesPageStateLoaded(
        defaultListFamily, defaultListFriend, defaultUserInfo, defaultListPet));
  }

  Future<void> updateInfo() async {
    try {
      emit(ProfilesShowPopUpLoading());
      final UserInfo userInfo = await userRepository.viewUserById();
      defaultUserInfo = userInfo;
      emit(ProfilesPageDismissLoading());
      emit(ProfilesPageStateLoaded(
          defaultListFamily, defaultListFriend, userInfo, defaultListPet));
    } on APIException catch (e) {
      emit(ProfilesPageDismissLoading());
      emit(ProfilesPageFailed(e.message()));
    }
  }
}
