import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/librarys/file_storages/file_storage.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'top_screen_state.dart';

class PageIndex {
  static const int album = 0;
  static const int news = 1;
  static const int favourite = 2;
  static const int account = 3;
}

class TopScreenCubit extends Cubit<TopScreenState> {
  TopScreenCubit()
      : super(TopScreenInitial(
            PageIndex.album, const <File>{}, PermissionPickMedia.family));

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> update(int index, Set<File> files, String permission) async {
    emit(TopScreenInitial(index, files, permission));
  }

  Future<void> uploadMedia(
      Set<File> files, String permission, int index) async {
    try {
      emit(TopScreenStateShowLoading());
      for (final File file in files) {
        final bool isVideo = FileStorage.listTypeFileVideo
            .contains(context.extension(file.path));
        await mediaRepository.createMedia(
            file, isVideo ? MediaType.video : MediaType.image, permission);
      }
      emit(TopScreenStateDismissLoading());
      emit(TopScreenInitial(index, files, permission));
    } on APIException catch (e) {
      emit(TopScreenStateDismissLoading());
      emit(TopScreenStateFail(e.message()));
    }
  }
}
