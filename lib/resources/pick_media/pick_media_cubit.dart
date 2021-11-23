import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';

part 'pick_media_state.dart';

class PickMediaCubit extends Cubit<PickMediaState> {
  PickMediaCubit()
      // ignore: prefer_const_literals_to_create_immutables
      : super(PickMediaInitial(<File>[], PermissionPickMedia.family));

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> updateImage(List<File> listImage, String permission) async {
    print('in here');
    emit(PickMediaInitial(listImage, permission));
  }

  Future<void> deleteFile(
      File file, List<File> listImage, String permission) async {
    listImage.removeWhere((File exitFile) => exitFile.path == file.path);
    emit(PickMediaInitial(listImage, permission));
  }

  Future<void> createMedia(List<File> listImage, String permission) async {
    try {
      emit(PickMediaStateShowPopUpLoading());
      for (final File file in listImage) {
        await mediaRepository.createMedia(file, MediaType.image, permission);
      }
      emit(PickMediaStateDismissPopUpLoading());
      emit(PickMediaStateSuccess());
    } on APIException catch (e) {
      emit(PickMediaStateDismissPopUpLoading());
      emit(PickMediaStateFail(e.message()));
    }
  }
}
