import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/component_helpers.dart';
import 'package:family_pet/general/components/permission_picker/permission_picker.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/image_details/image_details_cubit.dart';
import 'package:family_pet/resources/image_details/list_comment/list_comment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageDetailsPage extends StatefulWidget {
  const ImageDetailsPage({Key? key, required this.media}) : super(key: key);
  final Media media;

  @override
  State<ImageDetailsPage> createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  final ImageDetailsCubit cubit = ImageDetailsCubit();

  @override
  void initState() {
    cubit.updateMedia(widget.media);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageDetailsCubit, ImageDetailsState>(
      bloc: cubit,
      buildWhen: (ImageDetailsState prev, ImageDetailsState current) {
        if (current is ImageDetailsStateShowPopUpLoading) {
          showPopUpLoading(context);
          return false;
        } else if (current is ImageDetailsStateDismissPopUpLoading) {
          Navigator.pop(context);
          return false;
        } else if (current is ImageDetailsStateSuccess) {
          showMessage(context, AppStrings.of(context).notice,
              AppStrings.of(context).successDelete,
              actions: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context, Media());
                  },
                  child: Text(AppStrings.of(context).close)));
          return false;
        } else if (current is ImageDetailsStateShowMessage) {
          showMessage(context, AppStrings.of(context).notice, current.message);
          return false;
        } else
          return true;
      },
      builder: (BuildContext context, ImageDetailsState state) {
        if (state is ImageDetailsInitial) {
          return _body(context, state);
        } else
          return Container();
      },
    );
  }

  Widget _body(BuildContext context, ImageDetailsInitial state) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, state.media);
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                prefs!.getString(Constant.albumName)!.isNotEmpty
                    ? prefs!.getString(Constant.albumName)!
                    : AppStrings.of(context).textTitleAlbum,
                style: Theme.of(context).appBarTheme.titleTextStyle),
            leading: IconButton(
                onPressed: () => Navigator.pop(context, state.media),
                icon: const Icon(Icons.close)),
            actions: <Widget>[
              IconButton(
                  onPressed: () => showBottomSheet(context, state),
                  icon: const Icon(Icons.more_horiz))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomScrollView(
              slivers: <SliverList>[
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    const SizedBox(
                      height: 24,
                    ),
                    Hero(
                      tag: 'media${state.media.id}',
                      child: ComponentHelper.borderRadiusImage(
                        image: Image.network(
                          Url.baseURLImage + state.media.file!,
                        ),
                        borderRadius: 8.0,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/svgs/svg_comment.svg',
                          color: AppThemeData.color_black_80,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          state.media.totalComment!.toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        InkWell(
                          onTap: () => cubit.likeMedia(state.media),
                          child: state.media.isLiked!
                              ? SvgPicture.asset(
                                  'assets/svgs/svg_heart.svg',
                                  height: 20,
                                  width: 20,
                                )
                              : SvgPicture.asset(
                                  'assets/svgs/svg_like.svg',
                                  height: 20,
                                  width: 20,
                                  color: AppThemeData.color_black_80,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 27),
                    ListCommentWidget(
                      media: state.media,
                      onChangedTotalComment: (int totalComment) =>
                          cubit.updateMedia(
                              state.media.copyWith(totalComment: totalComment)),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context, ImageDetailsInitial state) {
    showModalBottomSheet<dynamic>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
      ),
      builder: (BuildContext context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                    onTap: () => Navigator.pop(context, false),
                    child: const Icon(Icons.close)),
                Expanded(
                  child: Text(
                    AppStrings.of(context).textChangeMediaPermission,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )
              ],
            ),
            Container(
              height: 48,
            ),
            PermissionPickerWidget(
                initPermission: state.media.share!,
                onPermissionPicked: (String per) {
                  cubit.updatePermission(state.media, per);
                }),
            Center(
              child: TextButton(
                onPressed: () {
                  showMessage(context, AppStrings.of(context).notice,
                      AppStrings.of(context).textPopUpConfirmDeleteMedia,
                      actions: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: AppThemeData.color_black_40),
                                onPressed: () => Navigator.pop(context),
                                child: Text(AppStrings.of(context)
                                    .textPopUpCancelButtonDelete)),
                          ),
                          Container(
                            width: 8,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  cubit.deleteMedia(state.media);
                                },
                                child: Text(AppStrings.of(context)
                                    .textPopUpConfirmButtonDelete)),
                          ),
                        ],
                      ));
                },
                child: Text(AppStrings.of(context).textDeleteMedia,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: AppThemeData.color_black_80)),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  cubit.saveImage(context, state.media);
                },
                child: Text(AppStrings.of(context).textSaveMediaToDevice,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: AppThemeData.color_black_80)),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          cubit.changePermission(
                              context, state.media, state.permission);
                        },
                        child: Container(
                            height: 50,
                            child: Center(
                                child: Text(
                              AppStrings.of(context).textSaveMediaChanges,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            ))))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
