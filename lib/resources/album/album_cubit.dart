import 'package:bloc/bloc.dart';
import 'package:family_pet/genaral/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(AlbumInitial());

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> getAlbum() async {
    try {
      emit(AlbumStateShowLoading());
      final List<Media> images = <Media>[];
      images.addAll(
          await mediaRepository.getAlbum(PermissionPickMedia.onlyMe) ??
              <Media>[]);
    } on APIException catch (e) {
      emit(AlbumStateDismissLoading());
      emit(AlbumStateFail(e.message()));
    }
  }
}
