part of 'album_cubit.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumStateShowPopUpLoading extends AlbumState {}

class AlbumStateDismissLoading extends AlbumState {}

class AlbumStateShowLoading extends AlbumState {}

class AlbumStateSuccess extends AlbumState {
  AlbumStateSuccess(this.images, this.selectedDateTime, this.albumType);

  final List<Media> images;
  final DateTime selectedDateTime;
  final String  albumType;
}

class AlbumStateFail extends AlbumState {
  AlbumStateFail(this.message);

  final String message;
}
