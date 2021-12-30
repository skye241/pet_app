import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/repository/media_repository.dart';
import 'package:family_pet/repository/pet_repository.dart';
import 'package:meta/meta.dart';

part 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit()
      : super(AlbumStateSuccess(
            const <Media>[], DateTime.now(), PermissionPickMedia.mine, List<DateTime>.generate(12, (int index) =>
      DateTime(DateTime.now().year, DateTime.now().month - index, 1)).toSet()));

  final MediaRepository mediaRepository = MediaRepository();
  final PetRepository petRepository = PetRepository();
  String defaultPermission = PermissionPickMedia.mine;
  Set<DateTime> defaultListDateTime = <DateTime>{};

  Future<void> initEvent() async {
    try {
      emit(AlbumStateShowLoading());
      final List<Media> images = <Media>[];
      images.addAll(
          await mediaRepository.getAlbum(defaultPermission) ?? <Media>[]);
      if (prefs!.getString(Constant.albumName) == null ||
          prefs!.getString(Constant.albumName)!.isEmpty) {
        final List<Pet> pets = <Pet>[];
        pets.addAll(await petRepository.getListPet());
        prefs!.setString(
            Constant.albumName,
            pets.isNotEmpty
                ? pets.map((Pet pet) => pet.name).toList().join('-')
                : '');
      }
      // final Set<DateTime> haveImageMonths = images.map((Media media) => DateTime(DateTime.parse(media.createdAt??'').year, DateTime.parse(media.createdAt??'').month, 1)).toSet();
      final Set<DateTime> haveImageMonths =  List<DateTime>.generate(12, (int index) =>
          DateTime(DateTime.now().year, DateTime.now().month - index, 1)).toSet();
      defaultListDateTime.addAll(haveImageMonths);
      emit(AlbumStateSuccess(images, DateTime.now(), defaultPermission, haveImageMonths));
    } on APIException catch (e) {
      emit(AlbumStateFail(e.message()));
    }
  }

  Future<void> changeAlbumType(String albumType) async {
    try {
      emit(AlbumStateShowLoading());
      final List<Media> images = <Media>[];
      images.addAll(await mediaRepository.getAlbum(albumType) ?? <Media>[]);
      defaultPermission = albumType;
      emit(AlbumStateSuccess(images, DateTime.now(), defaultPermission, defaultListDateTime));
    } on APIException catch (e) {
      emit(AlbumStateFail(e.message()));
    }
  }

  Future<void> chooseMonth(List<Media> images, DateTime date) async {
    emit(AlbumStateSuccess(images, date, defaultPermission, defaultListDateTime));
  }
}
