part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsStateLoaded extends NewsState {
  NewsStateLoaded(this.listComment);

  final List<Comment> listComment;
}
