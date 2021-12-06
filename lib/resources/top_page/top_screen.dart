import 'dart:convert';
import 'dart:io';

import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/main.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/album/views/album_page.dart';
import 'package:family_pet/resources/interests/views/interests_page.dart';
import 'package:family_pet/resources/news/views/news_page.dart';
import 'package:family_pet/resources/personal_profiles/views/profiles_page.dart';
import 'package:family_pet/resources/top_page/cubit/top_screen_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopScreenPage extends StatefulWidget {
  const TopScreenPage({Key? key, this.index}) : super(key: key);

  final int? index;

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
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // final StreamController<int> controller = StreamController<int>();

  @override
  void initState() {
    if (widget.index != null) {
      cubit.update(widget.index!);
    }
    super.initState();
    initializing();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider<TopScreenCubit>(
        create: (BuildContext context) => cubit,
        child: BlocBuilder<TopScreenCubit, TopScreenState>(
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
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TopScreenInitial state) {
    print('body rebuild');
    return Scaffold(
        bottomNavigationBar: _bottomNavigation(context, state, (int value) {
          cubit.update(value);
          // controller.sink.add(value);
        }),
        body: Column(
          children: <Widget>[
            Expanded(child: listBody[state.index]),
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

  // Widget _bottomNavigationBar(BuildContext context) async {}

  Widget _bottomNavigation(
      BuildContext context, TopScreenInitial state, Function(int) onChange) {
    print('navbar rebuild');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
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
                  label: AppStrings.of(context).textTitleAlbum,
                  linkSvgAsset: 'assets/svgs/svg_album.svg',
                  group: state.index,
                  state: state),
              _itemNavbar(
                  value: 1,
                  label: AppStrings.of(context).textTitleNews,
                  linkSvgAsset: 'assets/svgs/svg_new.svg',
                  group: state.index,
                  state: state),
              _centerButton(context, state),
              _itemNavbar(
                  value: 2,
                  label: AppStrings.of(context).textTitleInterests,
                  group: state.index,
                  linkSvgAsset: 'assets/svgs/svg_like.svg',
                  state: state),
              _itemNavbar(
                  value: 3,
                  label: AppStrings.of(context).textProfileTitle,
                  group: state.index,
                  linkSvgAsset: 'assets/svgs/svg_person.svg',
                  state: state),
            ],
          ),
        ),
      ],
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
      onTap: () => cubit.update(value),
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

  Future<void> initializing() async {
    firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      badge: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int? id,
        String? title,
        String? body,
        String? payload,
      ) async {
        print('hello receive background');
        // didReceiveLocalNotificationSubject.add(
        //   ReceivedNotification(
        //     id: id,
        //     title: title,
        //     body: body,
        //     payload: payload,
        //   ),
        // );
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        // selectNotificationSubject.add(payload);
      },
    );

    const AndroidNotificationDetails androidNotificationChannel =
        AndroidNotificationDetails(
      'FamiPet',
      'FamiPet',
      'FamiPet',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigTextStyleInformation(''),
    );
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(presentBadge: true);
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationChannel, iOS: iosNotificationDetails);

    // final String? token = await firebaseMessaging.getToken();
    // prefs!.setString(Constant.firebaseKey, token);

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      onMessage(remoteMessage, notificationDetails);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, RoutesName.topPage, arguments: <String, dynamic>{
        Constant.index : PageIndex.news,
      });
    });
  }
}

Future<void> onMessage(
    RemoteMessage msg, NotificationDetails platformChannelSpecifics) async {
  print('onMessage ${msg.data}');
  // print('onMessage-title ${msg.notification!.title}');
  // print('onMessage-data ${msg.notification!.body}');
  final List<String> notificationList =
      prefs!.getStringList(Constant.notificationList) ?? <String>[];

  // print('onMessage-content ${msg[Constant.media]}');

  try {
    // prefs!.setStringList(Constant.notificationList, <String>[]);
    Comment notification = Comment();
    if (Platform.isAndroid) {
      notification = Comment.fromMap(msg.data);
    } else if (Platform.isIOS) {
      notification = Comment.fromMap(
          jsonDecode(jsonEncode(msg.data)) as Map<String, dynamic>);
    }
    notification = notification.copyWith(
        createdDate: DateTime.now().millisecondsSinceEpoch);
    final List<Comment> listComment = notificationList
        .map((String noti) =>
            Comment.fromMap(jsonDecode(noti) as Map<String, dynamic>))
        .toList();
    listComment.removeWhere((Comment element) => element.id == notification.id);
    listComment.add(notification);
    prefs!.setStringList(Constant.notificationList,
        listComment.map((Comment e) => jsonEncode(e.toMap())).toList());
    // cubit.reload();

    flutterLocalNotificationsPlugin.show(
      msg.hashCode,
      msg.notification!.title,
      msg.notification!.body,
      platformChannelSpecifics,
    );
  } catch (error) {
    // flutterLocalNotificationsPlugin.show(
    //   0,
    //   'Thông báo',
    //   'Bạn vừa nhận được một thông báo mới',
    //   platformChannelSpecifics,
    // );
    print('Notification Error => $error ');
  }
}
