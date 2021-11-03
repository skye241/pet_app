import 'dart:async';

import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/album/views/album_page.dart';
import 'package:family_pet/resources/interests/views/interests_page.dart';
import 'package:family_pet/resources/news/views/news_page.dart';
import 'package:family_pet/resources/personal_profiles/views/profiles_page.dart';
import 'package:family_pet/resources/pick_media/views/pick_media_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopScreenPage extends StatelessWidget {
   TopScreenPage({Key? key}) : super(key: key);
  List<Widget> listBody = [
    AlbumPage(),
    NewsPage(),
    InterestsPage(),
    ProfileViewPage(),
  ];
  StreamController<int> controller =  StreamController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: StreamBuilder<int>(
            initialData: 0,
            stream: controller.stream,
            builder: (context,AsyncSnapshot<int> snapshot){
              return listBody[snapshot.data??0];
            },
          ),
        ),
        _bottomNavigation(onChange: (int value) {
          controller.sink.add(value);
        }),
      ],
    ));
  }

  Widget _centerButton(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..translate(0.0, -15.2),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PickMediaPage()));
        },
        child: CircleAvatar(
          radius: 31,
          backgroundColor: AppThemeData.color_main,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              "assets/svgs/svg_add_image.svg",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigation({Function(int)? onChange}) {
    int _index = 0;
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppThemeData.color_neutral_25,
              blurRadius: 2.0,
              spreadRadius: 2.0),
        ],
      ),
      child: StatefulBuilder(
        builder: (context, setStateNavbar) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              _itemNavbar(
                  value: 0,
                  label: "Album",
                  linkSvgAsset: "assets/svgs/svg_album.svg",
                  group: _index,
                  onTap: () {
                    setStateNavbar(() {
                      _index = 0;
                    });
                    if (onChange != null) onChange(0);
                  }),
              _itemNavbar(
                  value: 1,
                  label: "Bảng tin",
                  linkSvgAsset: "assets/svgs/svg_new.svg",
                  group: _index,
                  onTap: () {
                    setStateNavbar(() {
                      _index = 1;
                    });
                    if (onChange != null) onChange(1);
                  }),
              _centerButton(context),
              _itemNavbar(
                  value: 2,
                  label: "Yêu thích",
                  group: _index,
                  linkSvgAsset: "assets/svgs/svg_like.svg",
                  onTap: () {
                    setStateNavbar(() {
                      _index = 2;
                    });
                    if (onChange != null) onChange(2);
                  }),
              _itemNavbar(
                  value: 3,
                  label: "Cá nhân",
                  group: _index,
                  linkSvgAsset: "assets/svgs/svg_person.svg",
                  onTap: () {
                    setStateNavbar(() {
                      _index = 3;
                    });
                    if (onChange != null) onChange(3);
                  }),
            ],
          );
        },
      ),
    );
  }

  Widget _itemNavbar(
      {int? value,
      int? group,
      String? label,
      required String linkSvgAsset,
      String? badge,
      Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(linkSvgAsset,
                  color: value == group
                      ? AppThemeData.color_main
                      : AppThemeData.color_black_60),
              SizedBox(
                height: 2,
              ),
              Text(label ?? "",
                  style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: value == group
                          ? AppThemeData.color_main
                          : AppThemeData.color_black_60)),
            ],
          ),
          badge != null
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Text(
                    badge,
                    style: TextStyle(color: Colors.red),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
