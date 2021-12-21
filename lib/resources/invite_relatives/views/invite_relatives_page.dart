import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/components/permission_picker/permission_picker.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/url.dart';
import 'package:family_pet/general/tools/utils.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/model/enum.dart';
import 'package:family_pet/resources/invite_relatives/invite_relatives_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class InviteRelativePage extends StatefulWidget {
  const InviteRelativePage({
    Key? key,
  }) : super(key: key);

  @override
  State<InviteRelativePage> createState() => _InviteRelativePageState();
}

class _InviteRelativePageState extends State<InviteRelativePage> {
  final InviteRelativesCubit cubit = InviteRelativesCubit();

  @override
  void initState() {
    cubit.getAlbumByType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InviteRelativesCubit, InviteRelativesState>(
      bloc: cubit,
      listener: (BuildContext context, InviteRelativesState state) {
        if (state is InviteRelativesStateShowPopUpLoading) {
          showPopUpLoading(context);
        } else if (state is InviteRelativesStateDismissPopUpLoading) {
          Navigator.pop(context);
        } else if (state is InviteRelativesStateShowMessage) {
          showMessage(context, AppStrings.of(context).notice, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.of(context).textInviteRelativesTitle,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Text(AppStrings.of(context).textInviteRelativesLabelMain,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 24),
              Text(
                AppStrings.of(context).textInvitationTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 24),
              BlocBuilder<InviteRelativesCubit, InviteRelativesState>(
                bloc: cubit,
                buildWhen:
                    (InviteRelativesState prev, InviteRelativesState current) {
                  if (current is! InviteRelativesInitial &&
                      current is! InviteRelativesLoaded &&
                      current is! InviteRelativesStateFailed) {
                    return false;
                  } else
                    return true;
                },
                builder: (BuildContext context, InviteRelativesState state) {
                  if (state is InviteRelativesLoaded) {
                    if (state.media.id == null) {
                      return Container(
                        height: 220,
                        width: 220,
                        child: Center(
                          child:
                              Text(AppStrings.of(context).textEmptyShareMedia),
                        ),
                      );
                    }
                    return _itemFirst(context, state.media);
                  } else if (state is InviteRelativesInitial) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppThemeData.color_primary_90),
                    ));
                  } else if (state is InviteRelativesStateFailed) {
                    return ElevatedButton(
                        onPressed: () => cubit.getAlbumByType(),
                        child: const Text('Thử lại'));
                  } else
                    return Container();
                },
              ),
              const SizedBox(height: 24),
              PermissionPickerWidget(
                  listPermission: const <String>[
                    PermissionPickMedia.family,
                    PermissionPickMedia.friend
                  ],
                  initPermission: PermissionPickMedia.family,
                  chooseOne: true,
                  onPermissionPicked: (String per) => cubit.sortAlbum(per)),
              Expanded(child: Container()),
              BlocBuilder<InviteRelativesCubit, InviteRelativesState>(
                bloc: cubit,
                builder: (BuildContext context, InviteRelativesState state) {
                  return Column(
                    children: <Widget>[
                      Tooltip(
                        message: AppStrings.of(context).textTooltip,
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(horizontal: 50.0),
                        preferBelow: false,
                        verticalOffset: 50,
                        decoration: const BoxDecoration(
                          color: AppThemeData.color_main,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: cubit.media.id != null
                                ? () async {
                                    await Share.share(cubit.urlDefault);
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(Icons.share),
                                  const SizedBox(width: 16),
                                  Text(AppStrings.of(context)
                                      .textInviteRelativesButtonShare),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppThemeData.color_black_40,
                          ),
                          onPressed: cubit.media.id != null
                              ? () {
                                  Clipboard.setData(
                                          ClipboardData(text: cubit.urlDefault))
                                      .then((_) => showSnackBar(context));
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(
                                  Icons.copy,
                                  color: AppThemeData.color_black_80,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                    AppStrings.of(context)
                                        .textInviteRelativesButtonCopyUrl,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .copyWith(
                                            color:
                                                AppThemeData.color_black_80)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(
    BuildContext context,
    // @required ScaffoldMessengerState scaffoldMessengerStateKey,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(AppStrings.of(context).textInviteRelativesSuccessCopyUrl),
    ));
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

// Widget _itemFirst() {
//   return ClipRRect(
//     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//     child: Container(
//       width: 220,
//       height: 220,
//       child: Stack(
//         children: <Widget>[
//           Image.network(
//             'https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554__340.jpg',
//             fit: BoxFit.fill,
//             width: 220,
//             height: 220,
//           ),
//           Positioned(
//             bottom: 15,
//             left: 15,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const <Widget>[
//                 Text(
//                   '2021',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   'Tháng 08.2021',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700),
//                 ),
//                 Text(
//                   'Chó Top',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
