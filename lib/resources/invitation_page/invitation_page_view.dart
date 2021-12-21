import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/invitation_page/invitation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

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
  final InvitationCubit cubit = InvitationCubit();

  @override
  void initState() {
    cubit.initEvent(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<InvitationCubit, InvitationState>(
          bloc: cubit,
          buildWhen: (InvitationState prev, InvitationState current) {
            if (current is InvitationStateShowPopUp) {
              showPopUpLoading(context);
              return false;
            } else if (current is InvitationStateDismissPopUp) {
              Navigator.pop(context);
              return false;
            } else
              return true;
          },
          builder: (BuildContext context, InvitationState state) {
            if (state is InvitationInitial) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppThemeData.color_primary_90),
                  ),
                ],
              );
            } else if (state is InvitationStateLoaded) {
              return _invitation(
                  context,
                  state.media,
                  AppStrings.of(context).invitationTitle,
                  () => cubit.setRelationship(
                      widget.url, widget.userId, widget.typeShare),
                  AppStrings.of(context).invitationButtonAccept,
                  state,
                  question: AppStrings.of(context).invitationQuestion,
                  secondaryButtonFunction: () => Navigator.pop(context),
                  secondaryTitle:
                      AppStrings.of(context).invitationButtonReject);
            } else if (state is InvitationStateSuccessSetRela) {
              return _invitation(
                context,
                cubit.defaultMedia,
                AppStrings.of(context).invitationSuccess,
                () =>
                    Navigator.pushReplacementNamed(context, RoutesName.topPage),
                AppStrings.of(context).invitationButtonSuccess,
                state,
              );
            } else if (state is InvitationStateFailSetRela) {
              return _invitation(
                context,
                cubit.defaultMedia,
                AppStrings.of(context).invitationExpired,
                () => Navigator.popAndPushNamed(context, RoutesName.topPage),
                AppStrings.of(context).invitationButtonCancel,
                state,
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }

  Widget _invitation(
      BuildContext context,
      Media media,
      String title,
      VoidCallback activeButtonFunction,
      String activeButtonTitle,
      InvitationState state,
      {VoidCallback? secondaryButtonFunction,
      String? secondaryTitle,
      String? question}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 128,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                color: state is InvitationStateLoaded
                    ? null
                    : state is InvitationStateSuccessSetRela
                        ? AppThemeData.color_primary_90
                        : AppThemeData.color_warning),
          ),
          Container(
            height: 24,
          ),
          Text(
            AppStrings.of(context).textTitleAlbum,
            style: Theme.of(context).textTheme.headline3,
          ),
          Container(
            height: 16,
          ),
          _itemFirst(context, media),
          Container(
            height: 32,
          ),
          if (question != null)
            Text(
              question,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          Container(
            height: 38,
          ),
          SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                onPressed: activeButtonFunction,
                child: Text(
                  activeButtonTitle,
                )),
          ),
          Container(
            height: 16,
          ),
          if (secondaryButtonFunction != null)
            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    primary: AppThemeData.color_black_10,
                  ),
                  onPressed: secondaryButtonFunction,
                  child: Text(secondaryTitle ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: AppThemeData.color_black_80))),
            ),
        ],
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
                            DateFormat('MM.yyyy',
                                    prefs!.getString(Constant.language))
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
    );
  }
}
