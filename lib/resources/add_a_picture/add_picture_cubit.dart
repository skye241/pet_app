import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';

part 'add_picture_state.dart';

class AddPictureCubit extends Cubit<AddPictureState> {
  AddPictureCubit() : super(AddPictureInitial(null));

  final MediaRepository mediaRepository = MediaRepository();


  Future<void> changeImage (Set<File> images) async {
    emit(AddPictureInitial(images));
  }

  Future<void> createMedia(Set<File> images) async {
    try {
      emit(AddPictureStateShowLoading());
      await mediaRepository.createMedia('', MediaType.image);
      emit(AddPictureStateDismissLoading());
      emit(AddPictureStateSuccess());
    } on APIException catch (e) {
      emit(AddPictureStateDismissLoading());
      emit(AddPictureStateFail(e.message()));
    }
  }
}
