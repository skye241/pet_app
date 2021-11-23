import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/resources/album/views/album_page.dart';
import 'package:family_pet/resources/interests/views/interests_page.dart';
import 'package:family_pet/resources/news/views/news_page.dart';
import 'package:family_pet/resources/personal_profiles/views/profiles_page.dart';
import 'package:family_pet/resources/top_page/cubit/top_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopScreenPage extends StatefulWidget {
  const TopScreenPage({Key? key}) : super(key: key);

  @override
  State<TopScreenPage> createState() => _TopScreenPageState();
}

class _TopScreenPageState extends State<TopScreenPage> {
  final List<Widget> listBody = <Widget>[
    const AlbumPage(),
    const NewsPage(),
    const InterestsPage(),
    const ProfileViewPage(),
  ];
  final TopScreenCubit cubit = TopScreenCubit();

  // final StreamController<int> controller = StreamController<int>();

  @override
  Widget build(BuildContext context) {
    print(cubit.state);
    return BlocBuilder<TopScreenCubit, TopScreenState>(
      bloc: cubit,
      buildWhen: (TopScreenState prev, TopScreenState current) {
        if (current is! TopScreenInitial) {
          return false;
        } else
          return true;
      },
      builder: (BuildContext context, TopScreenState state) {
        if (state is TopScreenInitial) {
          return _body(context, state);
        } else
          return Container();
      },
    );
  }

  Widget _body(BuildContext context, TopScreenInitial state) {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(child: listBody[state.index]),
        _bottomNavigation(state, (int value) {
          cubit.update(value, state.images, state.permission);
          // controller.sink.add(value);
        }),
      ],
    ));
  }

  Widget _centerButton(BuildContext context, TopScreenInitial state) {
    return Transform(
      transform: Matrix4.identity()..translate(0.0, -15.2),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.pickMediaPage);
        },
        child: Container(
          decoration: const BoxDecoration(
              color: AppThemeData.color_main, shape: BoxShape.circle),
          padding: const EdgeInsets.all(14.0),
          child: SvgPicture.asset(
            'assets/svgs/svg_add_image.svg',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigation(TopScreenInitial state, Function(int) onChange) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppThemeData.color_neutral_25,
              blurRadius: 2.0,
              spreadRadius: 2.0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _itemNavbar(
              value: PageIndex.album,
              label: 'Album',
              linkSvgAsset: 'assets/svgs/svg_album.svg',
              group: state.index,
              state: state),
          _itemNavbar(
              value: 1,
              label: 'Bảng tin',
              linkSvgAsset: 'assets/svgs/svg_new.svg',
              group: state.index,
              state: state),
          _centerButton(context, state),
          _itemNavbar(
              value: 2,
              label: 'Yêu thích',
              group: state.index,
              linkSvgAsset: 'assets/svgs/svg_like.svg',
              state: state),
          _itemNavbar(
              value: 3,
              label: 'Cá nhân',
              group: state.index,
              linkSvgAsset: 'assets/svgs/svg_person.svg',
              state: state),
        ],
      ),
    );
  }

  Widget _itemNavbar({
    int value = PageIndex.album,
    String? label,
    required String linkSvgAsset,
    String? badge,
    int group = PageIndex.album,
    required TopScreenInitial state,
  }) {
    return InkWell(
      onTap: () => cubit.update(value, state.images, state.permission),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(linkSvgAsset,
                  color: value == group
                      ? AppThemeData.color_main
                      : AppThemeData.color_black_60),
              const SizedBox(
                height: 2,
              ),
              Text(label ?? '',
                  style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: value == group
                          ? AppThemeData.color_main
                          : AppThemeData.color_black_60)),
            ],
          ),
          if (badge != null)
            Positioned(
                top: 0,
                right: 0,
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.red),
                ))
          else
            Container(),
        ],
      ),
    );
  }
}
