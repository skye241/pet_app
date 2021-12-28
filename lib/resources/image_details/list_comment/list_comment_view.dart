import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/image_details/list_comment/list_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCommentWidget extends StatefulWidget {
  const ListCommentWidget(
      {Key? key, required this.media, required this.onChangedTotalComment})
      : super(key: key);

  final Media media;
  final ValueChanged<int> onChangedTotalComment;

  @override
  _ListCommentWidgetState createState() => _ListCommentWidgetState();
}

class _ListCommentWidgetState extends State<ListCommentWidget> {
  final ListCommentCubit cubit = ListCommentCubit();
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();

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
    return Form(
      key: formKey,
      onChanged: () {
        setState(() {});
      },
      child: BlocBuilder<ListCommentCubit, ListCommentState>(
          bloc: cubit,
          buildWhen: (ListCommentState prev, ListCommentState current) {
            if (current is ListCommentStateCallBack) {
              widget.onChangedTotalComment(current.totalComment);
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
                    textField(context, state.listComment),
                    Container(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                        AppStrings.of(context).textEmptyComment,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Container(
                      height: 32,
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
                        child: Text(AppStrings.of(context).retry))
                  ],
                ),
              );
            } else
              return Container();
          }),
    );
  }

  Widget textField(BuildContext context, List<Comment> listComment) {
    return ComponentHelper.textField(
      controller: commentController,
      focusNode: commentNode,
      onEditingComplete: () {
        cubit.postComment(widget.media, commentController.text, listComment);
        commentController.text = '';
        FocusScope.of(context).unfocus();
      },
      suffix: TextButton(
        onPressed: commentController.text.isEmpty
            ? null
            : () {
                cubit.postComment(
                    widget.media, commentController.text, listComment);
                commentController.text = '';
                FocusScope.of(context).unfocus();
              },
        child: Text(AppStrings.of(context).textButtonSend,
            style: TextStyle(
                color: commentController.text.isEmpty
                    ? AppThemeData.color_primary_30
                    : AppThemeData.color_primary_90)),
      ),
      hintText: AppStrings.of(context).textButtonWriteComment,
    );
  }

  Widget _body(BuildContext context, ListCommentInitial state) {
    return Column(
      children: <Widget>[
        textField(context, state.listComment),
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
    final String name = commentItem.userName ?? '';
    final String comment = commentItem.content ?? '';
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
                if (commentItem.avatar != null &&
                    commentItem.avatar!.isNotEmpty)
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(Url.baseURLImage + commentItem.avatar!),
                    radius: 16,
                  )
                else
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/img_user.png'),
                    radius: 16,
                    backgroundColor: Colors.white,
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: RichText(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: name + '  ',
                            style: Theme.of(context).textTheme.headline3),
                        TextSpan(
                            text: comment,
                            style: Theme.of(context).textTheme.bodyText2)
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (prefs!.getInt(Constant.userId) == commentItem.media!.user!.id ||
              prefs!.getInt(Constant.userId) == commentItem.user!.id)
            InkWell(
              onTap: () {
                showMessage(context, AppStrings.of(context).notice,
                    AppStrings.of(context).textPopUpConfirmDeleteComment,
                    actions: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(AppStrings.of(context)
                                .textPopUpCancelButtonDelete),
                            style: ElevatedButton.styleFrom(
                                primary: AppThemeData.color_black_40),
                          ),
                        ),
                        Container(
                          width: 8,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.deleteComment(commentItem, listComment,
                                    formKey.currentState!.validate());
                              },
                              child: Text(AppStrings.of(context)
                                  .textPopUpConfirmButtonDelete)),
                        ),
                      ],
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  AppStrings.of(context).delete,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
