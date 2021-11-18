import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';

part 'interests_page_state.dart';

class InterestsPageCubit extends Cubit<InterestsPageState> {
  InterestsPageCubit() : super(InterestsPageInitial());

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> getAlbum() async {
    try {
      emit(InterestsPageStateLoading());
      final List<Media> listMedia =
          await mediaRepository.getFavouriteMedia() ?? <Media>[];
      emit(InterestsPageStateSuccess(listMedia));
    } on APIException catch (e) {
      emit(InterestsPageStateFail(e.message()));
    }
  }
}
