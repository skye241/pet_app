import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/calendar_slide/calendar_slide_view.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/album/album_cubit.dart';
import 'package:family_pet/resources/album/views/media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final AlbumCubit cubit = AlbumCubit();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    cubit.initEvent();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlbumCubit, AlbumState>(
      bloc: cubit,
      listener: (BuildContext context, AlbumState current) {
        if (current is AlbumStateShowPopUpLoading) {
          showPopUpLoading(context);
        } else if (current is AlbumStateDismissLoading) {
          Navigator.pop(context);
        } else if (current is AlbumStateFail) {
          showMessage(context, AppStrings.of(context).notice, current.message);
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
              return _body(context, state);
            } else
              return _emptyWidget(context);
          } else
            return Scaffold(
              appBar: AppBar(
                title: const Text('Album'),
              ),
              body: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppThemeData.color_primary_90),
                ),
              ),
            );
        },
      ),
    );
  }

  Widget _emptyWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album'),
      ),
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: AppThemeData.color_primary_90,
          child: Column(),
          onRefresh: () async => cubit.initEvent()),
    );
  }

  Widget _body(BuildContext context, AlbumStateSuccess state) {
    final List<Media> qualifyMedia = state.images
        .where((Media media) =>
            DateTime.parse(media.createdAt!).month ==
                state.selectedDateTime.month &&
            DateTime.parse(media.createdAt!).year ==
                state.selectedDateTime.year)
        .toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          state.petTypes.map((Pet e) => e.name).toList().join('-'),
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppThemeData.color_primary_90,
        onRefresh: () async => cubit.initEvent(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateTime.now().year.toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 8,
              ),
              MonthPickerWidget(
                numberOfMonth: 12,
                onMonthSelect: (DateTime date) =>
                    cubit.chooseMonth(state.images, state.petTypes, date),
              ),
              const SizedBox(
                height: 20,
              ),
              if (qualifyMedia.isNotEmpty)
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      _itemFirst(context, qualifyMedia.first),
                      Container(
                        height: 8,
                      ),
                      GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: qualifyMedia
                              .sublist(1, qualifyMedia.length)
                              .map((Media media) => MediaWidget(
                                    media: media,
                                    cubit: cubit,
                                  ))
                              .toList()),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemFirst(BuildContext context, Media media) {
    final DateTime date = DateTime.parse(media.createdAt!);
    final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color.fromRGBO(82, 87, 92, 0),
          const Color(0xff52575C).withOpacity(0.5)
        ]);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RoutesName.imageDetails,
              arguments: <String, dynamic>{Constant.media: media})
          .then((_) => cubit.initEvent()),
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
                        media.file!,
                        fit: BoxFit.fill,
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
                              date.year.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              AppStrings.of(context).month +
                                  DateFormat('MM.yyyy',
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
}
