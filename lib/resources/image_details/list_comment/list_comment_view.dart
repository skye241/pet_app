import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/image_details/list_comment/list_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCommentWidget extends StatefulWidget {
  const ListCommentWidget(
      {Key? key, required this.media, this.onChangedTotalComment})
      : super(key: key);

  final Media media;
  final ValueChanged<int>? onChangedTotalComment;

  @override
  _ListCommentWidgetState createState() => _ListCommentWidgetState();
}

class _ListCommentWidgetState extends State<ListCommentWidget> {
  final ListCommentCubit cubit = ListCommentCubit();
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentNode = FocusNode();

  @override
  void initState() {
    cubit.initEvent(widget.media);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    commentController.dispose();
    commentNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCommentCubit, ListCommentState>(
        bloc: cubit,
        buildWhen: (ListCommentState prev, ListCommentState current) {
          if (current is ListCommentStateCallBack) {
            widget.onChangedTotalComment!(current.totalComment);
            return false;
          } else
            return true;
        },
        builder: (BuildContext context, ListCommentState state) {
          if (state is ListCommentInitial) {
            if (state.listComment.isNotEmpty) {
              return _body(context, state);
            } else
              return Column(
                children: <Widget>[
                  ComponentHelper.textField(
                    controller: commentController,
                    focusNode: commentNode,
                    onEditingComplete: () => cubit.postComment(widget.media,
                        commentController.text, state.listComment),
                    suffix: TextButton(
                      onPressed: () => cubit.postComment(widget.media,
                          commentController.text, state.listComment),
                      child: Text('Gửi',
                          style:
                              TextStyle(color: Colors.green.withOpacity(0.55))),
                    ),
                    hintText: 'Viết comment',
                  ),
                  Container(
                    height: 24,
                  ),
                  Center(
                    child: Text(
                      'Chưa có bình luận',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ],
              );
          } else if (state is ListCommentStateLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppThemeData.color_primary_90),
              ),
            );
          } else if (state is ListCommentStateFail) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(state.message),
                  Container(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () => cubit.initEvent(widget.media),
                      child: const Text('Thử lại'))
                ],
              ),
            );
          } else
            return Container();
        });
  }

  Widget _body(BuildContext context, ListCommentInitial state) {
    return Column(
      children: <Widget>[
        ComponentHelper.textField(
          controller: commentController,
          focusNode: commentNode,
          onEditingComplete: () => cubit.postComment(
              widget.media, commentController.text, state.listComment),
          suffix: TextButton(
            onPressed: () => cubit.postComment(
                widget.media, commentController.text, state.listComment),
            child: Text('Gửi',
                style: TextStyle(color: Colors.green.withOpacity(0.55))),
          ),
          hintText: 'Viết comment',
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _itemComment(context,
                commentItem: state.listComment[index],
                listComment: state.listComment);
          },
          itemCount: state.listComment.length,
        ),
      ],
    );
  }

  Widget _itemComment(
    BuildContext context, {
    required Comment commentItem,
    required List<Comment> listComment,
  }) {
    const String link =
        'https://toppng.com/uploads/preview/cool-avatar-transparent-image-cool-boy-avatar-11562893383qsirclznyw.png';
    final String name = commentItem.userName!;
    final String comment = commentItem.content ?? '';
    print(name);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CircleAvatar(
                  backgroundImage: NetworkImage(link),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(name,
                            style: Theme.of(context).textTheme.headline3),
                        Container(
                          width: 8,
                        ),
                        Text(comment,
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (prefs!.getInt(Constant.userId) == commentItem.media!.user!.id ||
              prefs!.getInt(Constant.userId) == commentItem.user!.id)
            InkWell(
              onTap: () => cubit.deleteComment(commentItem, listComment),
              child: const Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Xoá',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
