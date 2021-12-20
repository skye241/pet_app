import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:flutter/material.dart';

class NewsListDataFragment extends StatelessWidget {
  const NewsListDataFragment({Key? key, required this.listNotification})
      : super(key: key);

  final List<Comment> listNotification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25.0),
            itemBuilder: (BuildContext context, int index) {
              return _itemNews(context, listNotification[index]);
            },
            separatorBuilder: (BuildContext context, int snapshot) {
              return const Divider(
                indent: 20,
                endIndent: 20,
                height: 22,
              );
            },
            itemCount: listNotification.length,
          ),
        ),
      ],
    );
  }

  Widget _itemNews(BuildContext context, Comment comment) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RoutesName.imageDetails,
          arguments: <String, dynamic>{Constant.media: comment.media}),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(Url.baseURLImage + comment.media!.file!)),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          prefs!.getString(Constant.albumName) ??
                              AppStrings.of(context).textTitleAlbum,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: AppThemeData.color_primary_90),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        RichText(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: comment.userName! + '  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: AppThemeData.color_black_80),
                              ),
                              // Container(width: 4,),
                              TextSpan(
                                text: comment.content ?? '',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    createString(
                        context,
                        DateTime.now().difference(
                            DateTime.fromMillisecondsSinceEpoch(
                                comment.createdDate!))),
                    style: const TextStyle(
                        color: AppThemeData.color_grey_3,
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String createString(BuildContext context, Duration time) {
    if (time.inMinutes >= 0 && time.inMinutes <= 1) {
      return AppStrings.of(context).recently;
    } else if (1 < time.inMinutes && time.inMinutes < 60) {
      return time.inMinutes.toString() + ' ' + AppStrings.of(context).minute;
    } else if (time.inMinutes >= 60 && time.inMinutes < 24 * 60) {
      return time.inHours.toString() + ' ' + AppStrings.of(context).hour;
    } else
      return time.inDays.toString() + ' ' + AppStrings.of(context).day;
  }
}
