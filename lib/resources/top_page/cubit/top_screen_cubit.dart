import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';

part 'top_screen_state.dart';

class TopScreenCubit extends Cubit<TopScreenState> {
  TopScreenCubit() : super(TopScreenInitial());

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> uploadMedia(String file) async {
    try {
      emit(TopScreenStateShowLoading());
      await mediaRepository.createMedia(file, MediaType.image);
      emit(TopScreenStateDismissLoading());
      emit(TopScreenStateSuccess());
    } on APIException catch (e) {
      emit(TopScreenStateDismissLoading());
      emit(TopScreenStateFail(e.message()));
    }
  }
}
