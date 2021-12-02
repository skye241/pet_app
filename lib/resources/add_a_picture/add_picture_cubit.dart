import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_picture_state.dart';

class AddPictureCubit extends Cubit<AddPictureState> {
  AddPictureCubit() : super(AddPictureInitial(null, PermissionPickMedia.family));

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> update(File? image, String permission) async {
    emit(AddPictureInitial(image, permission));
  }

  Future<void> createMedia(File image, String permission, BuildContext context) async {
    try {
      emit(AddPictureStateShowLoading());
      await mediaRepository.createMedia(
          image, MediaType.image, permission);

      emit(AddPictureStateDismissLoading());
      emit(AddPictureStateSuccess());
    } on Exception{
      emit(AddPictureStateDismissLoading());
      emit(AddPictureStateFail(AppStrings.of(context).textErrorCannotUploadImage));
    }
  }
}
