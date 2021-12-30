import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/album/album_cubit.dart';
import 'package:family_pet/resources/album/views/album_empty_fragment.dart';
import 'package:family_pet/resources/album/views/media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';


const int TILE_WIDTH = 84;
// Block Spacing

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final AlbumCubit cubit = AlbumCubit();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  PageController? _pageController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    cubit.initEvent();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AlbumCubit, AlbumState>(
        bloc: cubit,
        builder: (BuildContext context, AlbumState state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      getTitleAlbum(context),
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    IconButton(
                        onPressed: () => showListAlbum(context),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined))
                  ],
                ),
              ),
            ),
            body: BlocListener<AlbumCubit, AlbumState>(
              bloc: cubit,
              listener: (BuildContext context, AlbumState current) {
                if (current is AlbumStateShowPopUpLoading) {
                  showPopUpLoading(context);
                } else if (current is AlbumStateDismissLoading) {
                  Navigator.pop(context);
                } else if (current is AlbumStateFail) {
                  showMessage(
                      context, AppStrings.of(context).notice, current.message);
                }
              },
              child: BlocBuilder<AlbumCubit, AlbumState>(
                bloc: cubit,
                buildWhen: (AlbumState prev, AlbumState current) {
                  print(current);
                  if (current is AlbumStateSuccess ||
                      current is AlbumInitial ||
                      current is AlbumStateShowLoading) {
                    return true;
                  } else
                    return false;
                },
                builder: (BuildContext context, AlbumState state) {
                  if (state is AlbumInitial) {
                    return _emptyWidget(context);
                  } else if (state is AlbumStateSuccess) {
                    if (state.images.isNotEmpty) {
                      return _body(context, state, state.images);
                    } else
                      return Center(
                        child: AlbumEmptyFragment(
                          title: AppStrings.of(context).textLabelAlbumEmpty +
                              (cubit.defaultPermission == PermissionPickMedia.mine
                                  ? '\n${AppStrings.of(context).textSubLabelAlbumEmpty}'
                                  : ''),
                        ),
                      );
                  } else
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppThemeData.color_primary_90),
                      ),
                    );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _emptyWidget(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppThemeData.color_primary_90,
        child: Column(),
        onRefresh: () async => cubit.initEvent());
  }

  Widget _body(
      BuildContext context, AlbumStateSuccess state, List<Media> qualifyMedia) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            state.selectedDateTime.year.toString() +
                (prefs!.getString(Constant.language) == 'ja'
                    ? AppStrings.of(context).year
                    : ''),
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      width: 16,
                    ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        cubit.chooseMonth(
                            state.images, state.listDateTime.elementAt(index));
                        _pageController!.animateToPage(index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        // cubit.chooseMonth(
                        //     state.listDateTime[index], state.listDateTime);
                        // widget.onMonthSelect!(state.listDateTime[index]);
                      },
                      child: Container(
                        width: TILE_WIDTH - 16,
                        child: Text(
                          (prefs!.getString(Constant.language) == 'vi'
                                  ? AppStrings.of(context).month +
                                      state.listDateTime
                                          .elementAt(index)
                                          .month
                                          .toString()
                                  : state.listDateTime
                                          .elementAt(index)
                                          .month
                                          .toString() +
                                      AppStrings.of(context).month) +
                              (state.listDateTime.elementAt(index).year ==
                                      state.selectedDateTime.year
                                  ? ''
                                  : '/${state.listDateTime.elementAt(index).year}'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: (state.selectedDateTime.month ==
                                              state.listDateTime
                                                  .elementAt(index)
                                                  .month) &&
                                          (state.selectedDateTime.year ==
                                              state.listDateTime
                                                  .elementAt(index)
                                                  .year)
                                      ? AppThemeData.color_primary_90
                                      : AppThemeData.color_black_40),
                        ),
                      ),
                    ),
                itemCount: state.listDateTime.length),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                cubit.chooseMonth(
                    state.images, state.listDateTime.elementAt(index));
                _scrollController.animateTo(index * TILE_WIDTH.toDouble() - 32,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 200));
              },
              allowImplicitScrolling: true,
              itemBuilder: (BuildContext context, int index) {
                final List<Media> images = state.images
                    .where((Media e) =>
                        DateTime.parse(e.createdAt!).month ==
                            state.listDateTime.elementAt(index).month &&
                        DateTime.parse(e.createdAt!).year ==
                            state.listDateTime.elementAt(index).year)
                    .toList();
                if (images.isNotEmpty) {
                  return listImage(context, images, state);
                } else
                  return Center(
                      child: AlbumEmptyFragment(
                    title: AppStrings.of(context).textLabelAlbumEmpty,
                  ));
              },
              itemCount: state.listDateTime.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget listImage(
      BuildContext context, List<Media> qualifyMedia, AlbumStateSuccess state) {
    return ListView(
      children: <Widget>[
        if (MediaQuery.of(context).size.width > 750)
          Row(children: <Widget>[
            Expanded(child: _itemFirst(context, qualifyMedia.first, state)),
            Flexible(
              child: _itemFirst(context, qualifyMedia[1], state)
            )
          ])
        else
          _itemFirst(context, qualifyMedia.first, state),
        Container(
          height: 8,
        ),
        GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 750 ? 4 : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: qualifyMedia
                .sublist(MediaQuery.of(context).size.width > 750 ? 2 : 1,
                    qualifyMedia.length)
                .map((Media media) => MediaWidget(
                      media: media,
                      onMediaUpdate: (Media returnMedia) {
                        if (returnMedia.id == null) {
                          state.images.removeWhere(
                              (Media stateMedia) => stateMedia.id == media.id);
                          cubit.chooseMonth(
                              state.images, state.selectedDateTime);
                        } else {
                          final int index = state.images.indexWhere(
                              (Media stateMedia) => stateMedia.id == media.id);
                          state.images[index] = returnMedia;
                          cubit.chooseMonth(
                              state.images, state.selectedDateTime);
                        }
                      },
                    ))
                .toList()),
      ],
    );
  }

  Widget _itemFirst(
      BuildContext context, Media media, AlbumStateSuccess state) {
    final DateTime date = DateTime.parse(media.createdAt!);
    final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color.fromRGBO(82, 87, 92, 0),
          const Color(0xff52575C).withOpacity(0.5)
        ]);
    return InkWell(
      onTap: () => onMediaClick(context, media, state),
      child: Hero(
        tag: 'media${media.id}',
        child: Row(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    if (media.file != null && media.file!.isNotEmpty)
                      Image.network(
                        Url.baseURLImage + media.file!,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 16, left: 16, right: 16),
                        decoration: BoxDecoration(gradient: gradient),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              date.year.toString() +
                                  (prefs!.getString(Constant.language) == 'ja'
                                      ? AppStrings.of(context).year
                                      : ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              prefs!.getString(Constant.language) == 'vi'
                                  ? AppStrings.of(context).month +
                                      DateFormat(
                                              'MM.yyyy',
                                              prefs!
                                                  .getString(Constant.language))
                                          .format(date)
                                  : DateFormat(
                                          'yyyy ${AppStrings.of(context).year} MM ${AppStrings.of(context).month}',
                                          prefs!.getString(Constant.language))
                                      .format(date),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  void showListAlbum(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppStrings.of(context).textPopUpLabelChooseAlbum),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                checkBoxListTile(PermissionPickMedia.mine,
                    AppStrings.of(context).textInvitationTitle),
                checkBoxListTile(PermissionPickMedia.family,
                    AppStrings.of(context).textTabFamily),
                checkBoxListTile(PermissionPickMedia.friend,
                    AppStrings.of(context).textTabFriend)
              ],
            ),
          );
        });
  }

  Widget checkBoxListTile(String type, String title) {
    return RadioListTile<String>(
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        title: Text(title),
        activeColor: AppThemeData.color_primary_90,
        groupValue: cubit.defaultPermission,
        value: type,
        onChanged: (String? value) {
          Navigator.pop(context);
          if (cubit.defaultPermission != type) {
            cubit.changeAlbumType(type);
          }
        });
  }

  Future<void> onMediaClick(
      BuildContext context, Media media, AlbumStateSuccess state) async {
    final Media? returnMedia = await Navigator.pushNamed(
        context, RoutesName.imageDetails,
        arguments: <String, dynamic>{Constant.media: media}) as Media?;
    if (returnMedia != null) {
      if (returnMedia.id == null) {
        state.images
            .removeWhere((Media stateMedia) => stateMedia.id == media.id);
        cubit.chooseMonth(state.images, state.selectedDateTime);
      } else {
        final int index = state.images
            .indexWhere((Media stateMedia) => stateMedia.id == media.id);
        state.images[index] = returnMedia;
        cubit.chooseMonth(state.images, state.selectedDateTime);
      }
    }
  }

  String getTitleAlbum(BuildContext context) {
    if (cubit.defaultPermission == PermissionPickMedia.mine) {
      return (prefs!.getString(Constant.albumName) != null &&
              prefs!.getString(Constant.albumName)!.isNotEmpty)
          ? prefs!.getString(Constant.albumName)!
          : AppStrings.of(context).textTitleAlbum;
    } else if (cubit.defaultPermission == PermissionPickMedia.family) {
      return AppStrings.of(context).textSubLabelFamily;
    } else
      return AppStrings.of(context).textSubLabelFriend;
  }
}
