import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaWidget extends StatelessWidget {
  const MediaWidget(
      {Key? key, required this.media, required this.onMediaUpdate})
      : super(key: key);

  final Media media;
  final ValueChanged<Media> onMediaUpdate;

  @override
  Widget build(BuildContext context) {
    return _otherImage(context, media);
  }

  Widget _otherImage(BuildContext context, Media media) {
    // final BoxShadow boxShadow = BoxShadow(
    //   color: Color(0xff52575C),
    //   blurRadius: 6
    // );
    final Gradient gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          const Color.fromRGBO(82, 87, 92, 0),
          const Color(0xff52575C).withOpacity(0.5)
        ]);
    return InkWell(
      onTap: () async {
        final dynamic needReload = await Navigator.pushNamed(
            context, RoutesName.imageDetails,
            arguments: <String, dynamic>{Constant.media: media});
        if (needReload != null) {
          onMediaUpdate(needReload as Media);
        }
      },
      child: Hero(
        tag: 'media${media.id}',
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: Stack(
            children: <Widget>[
              if (media.file != null && media.file!.isNotEmpty)
                Container(
                  width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                  Url.baseURLImage + media.file!,
                  fit: BoxFit.cover,
                ))
              // Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //     image: NetworkImage(Url.baseURLImage + media.file!),
              //     fit: BoxFit.cover,
              //   )),
              // )
              else
                Container(),
              if (media.totalComment! > 0 || media.isLiked!)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 42, // width: double.maxFinite,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (media.totalComment! > 0)
                          Row(
                            children: <Widget>[
                              SvgPicture.asset('assets/svgs/svg_comment.svg'),
                              Container(
                                width: 6,
                              ),
                              Text(
                                media.totalComment!.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        if (media.totalComment! > 0)
                          Expanded(child: Container()),
                        if (media.isLiked!)
                          SvgPicture.asset('assets/svgs/svg_heart.svg'),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: AppThemeData.color_black_40,
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
