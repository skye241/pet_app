import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';

part 'add_picture_state.dart';

class AddPictureCubit extends Cubit<AddPictureState> {
  AddPictureCubit() : super(AddPictureInitial(null, PermissionPickMedia.family));

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> changeImage(File image, String permission) async {
    emit(AddPictureInitial(image, permission));
  }

  Future<void> createMedia(File image, String permission) async {
    try {
      emit(AddPictureStateShowLoading());
      await mediaRepository.createMedia(
          image, MediaType.image, permission);

      emit(AddPictureStateDismissLoading());
      emit(AddPictureStateSuccess());
    } on Exception catch (e) {
      emit(AddPictureStateDismissLoading());
      emit(AddPictureStateFail('Không upload ảnh được'));
    }
  }
}
