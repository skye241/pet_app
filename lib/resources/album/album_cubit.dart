import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:family_pet/repository/pet_repository.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit()
      : super(
            AlbumStateSuccess(const <Media>[], const <Pet>[], DateTime.now()));

  final MediaRepository mediaRepository = MediaRepository();
  final PetRepository petRepository = PetRepository();

  Future<void> initEvent() async {
    try {
      emit(AlbumStateShowLoading());
      final List<Media> images = <Media>[];
      images.addAll(await mediaRepository.getAlbum(PermissionPickMedia.mine) ??
          <Media>[]);
      final List<Pet> pets = <Pet>[];
      pets.addAll(await petRepository.getListPet() ?? <Pet>[]);
      emit(AlbumStateSuccess(images, pets, DateTime.now()));
    } on APIException catch (e) {
      emit(AlbumStateFail(e.message()));
    }
  }

  Future<void> chooseMonth(
      List<Media> images, List<Pet> pets, DateTime date) async {
    emit(AlbumStateSuccess(images, pets, date));
  }
}
