import 'package:bloc/bloc.dart';
import 'package:family_pet/general/api_handler.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/repository/comment_repository.dart';
import 'package:meta/meta.dart';

part 'list_comment_state.dart';

class ListCommentCubit extends Cubit<ListCommentState> {
  ListCommentCubit() : super(ListCommentInitial(const <Comment>[], false));

  final CommentRepository commentRepository = CommentRepository();

  Future<void> initEvent(Media media) async {
    try {
      emit(ListCommentStateLoading());
      final List<Comment> listComment = <Comment>[];
      listComment.addAll(
          await commentRepository.getListComment(media.id!) ?? <Comment>[]);
      print(listComment);
      emit(ListCommentInitial(listComment, false));
    } on APIException catch (e) {
      emit(ListCommentStateFail(e.message()));
    }
  }

  Future<void> updateEnable(bool enable, List<Comment> listComment) async {
    emit(ListCommentInitial(listComment, enable));
  }

  Future<void> postComment(
      Media media, String content, List<Comment> listComment) async {
    try {
      final int commentId = await commentRepository.postComment(
          media.id!, media.user!.id!, content);
      listComment.insert(
          0,
          Comment(
              media: media,
              user: User(
                  id: prefs!.getInt(Constant.userId),
                  email: prefs!.getString(Constant.email)),
              content: content,
              id: commentId,
              userName: prefs!.getString(Constant.fullName),
              avatar: prefs!.getString(Constant.avatar)));
      emit(ListCommentStateCallBack(listComment.length));
      emit(ListCommentInitial(listComment, false));
    } on APIException {
      emit(ListCommentInitial(listComment, true));
    }
  }

  Future<void> deleteComment(
      Comment comment, List<Comment> listComment, bool enable) async {
    try {
      await commentRepository.delComment(comment.id!);
      listComment.removeWhere((Comment e) => e.id == comment.id);
      emit(ListCommentStateCallBack(listComment.length));
      emit(ListCommentInitial(listComment, enable));
    } on APIException {
      emit(ListCommentInitial(listComment, enable));
    }
  }
}
