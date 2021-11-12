part of 'album_cubit.dart';

@immutable
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumStateShowLoading extends AlbumState{}
class AlbumStateDismissLoading extends AlbumState{}
class AlbumStateSuccess extends AlbumState{
  AlbumStateSuccess(this.images);

  final List<Media> images;
}
class AlbumStateFail extends AlbumState{
  AlbumStateFail(this.message);

  final String message;
}