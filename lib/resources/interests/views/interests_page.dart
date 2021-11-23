import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/album/views/media_widget.dart';
import 'package:family_pet/resources/interests/interests_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({Key? key}) : super(key: key);

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final InterestsPageCubit cubit = InterestsPageCubit();

  @override
  void initState() {
    cubit.getAlbum();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.of(context).textTitleInterests,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: BlocBuilder<InterestsPageCubit, InterestsPageState>(
          bloc: cubit,
          builder: (BuildContext context, InterestsPageState state) {
            if (state is InterestsPageStateSuccess) {
              if (state.listImage.isNotEmpty) {
                return _body(context, state);
              } else
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child:
                          Text(AppStrings.of(context).textEmptyFavouriteMedia),
                    ),
                  ],
                );
            } else if (state is InterestsPageStateLoading) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppThemeData.color_primary_90),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is InterestsPageStateFail) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(state.message),
                    ),
                  ],
                ),
              );
            } else
              return Container();
          },
        ));
  }

  Widget _body(BuildContext context, InterestsPageStateSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: state.listImage.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              state.listImage.length < 3 ? state.listImage.length : 3,
          crossAxisSpacing: 6.0,
          mainAxisSpacing: 6.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return MediaWidget(media: state.listImage[index]);
        },
      ),
    );
  }

  Widget _itemGridView(Media media) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            image: DecorationImage(
                image: NetworkImage(
                  Url.baseURLImage + media.file!,
                ),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          child: Row(
            children: <Widget>[
              SvgPicture.asset('assets/svgs/svg_message.svg'),
              const SizedBox(
                width: 2,
              ),
              Text(
                media.totalComment.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              )
            ],
          ),
          bottom: 8,
          left: 8,
        ),
        Positioned(
          child: SvgPicture.asset('assets/svgs/svg_heart.svg'),
          bottom: 8,
          right: 8,
        ),
      ],
    );
  }
}
