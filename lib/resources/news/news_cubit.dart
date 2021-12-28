import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/model/entity.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  Future<void> initEvent() async {
    await prefs?.reload();
    final List<String> notiString =
        prefs!.getStringList(Constant.notificationList) ?? <String>[];

    final List<Comment> listComment = notiString
        .map((String noti) =>
            Comment.fromMap(jsonDecode(noti) as Map<String, dynamic>))
        .toList();
    if (listComment.isNotEmpty) {
      listComment.sort(
          (Comment b, Comment a) => a.createdDate!.compareTo(b.createdDate!));
    }
    emit(NewsStateLoaded(listComment));
  }
}
