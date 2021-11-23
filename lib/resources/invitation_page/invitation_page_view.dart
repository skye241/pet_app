import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/model/entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage(
      {Key? key,
      required this.userId,
      required this.typeShare,
      required this.url})
      : super(key: key);

  final int userId;
  final String typeShare;
  final String url;

  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _invitation(BuildContext context, ShareEntity link) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 128,
            ),
            Text(
              AppStrings.of(context).invitationTitle,
              style: Theme.of(context).textTheme.headline2,
            ),
            Container(
              height: 24,
            ),
            Text(
              link.albumName!.isNotEmpty ? link.albumName! : 'Album của bạn',
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              height: 16,
            ),
            _itemFirst(context, link.media!),
            Container(
              height: 32,
            ),
            Text(
              AppStrings.of(context).invitationQuestion,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Container(
              height: 38,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(AppStrings.of(context).invitationButtonAccept))
          ],
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
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Stack(
        children: <Widget>[
          if (media.file != null && media.file!.isNotEmpty)
            Container(
              width: 220,
              height: 220,
              child: Image.network(
                Url.baseURLImage + media.file!,
                fit: BoxFit.cover,
              ),
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
                        DateFormat('MM.yyyy', 'vi').format(date),
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
    );
  }
}
