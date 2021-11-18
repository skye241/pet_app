part of 'album_cubit.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumStateShowPopUpLoading extends AlbumState {}

class AlbumStateDismissLoading extends AlbumState {}

class AlbumStateShowLoading extends AlbumState {}

class AlbumStateSuccess extends AlbumState {
  AlbumStateSuccess(this.images, this.petTypes, this.selectedDateTime);

  final List<Media> images;
  final List<Pet> petTypes;
  final DateTime selectedDateTime;
}

class AlbumStateFail extends AlbumState {
  AlbumStateFail(this.message);

  final String message;
}
