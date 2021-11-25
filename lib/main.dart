import 'dart:convert';
import 'dart:io';

import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/add_a_picture/views/add_a_picture_page.dart';
import 'package:family_pet/resources/default_page/default_page.dart';
import 'package:family_pet/resources/fast_register_user/views/register_fast_user_page.dart';
import 'package:family_pet/resources/image_details/image_details_page.dart';
import 'package:family_pet/resources/interests/views/interests_page.dart';
import 'package:family_pet/resources/introduces/views/introduce_page.dart';
import 'package:family_pet/resources/invitation_page/invitation_page_view.dart';
import 'package:family_pet/resources/invite_relatives/views/invite_relatives_page.dart';
import 'package:family_pet/resources/language/language_cubit.dart';
import 'package:family_pet/resources/list_of_relatives/views/list_relatives_page.dart';
import 'package:family_pet/resources/news/views/news_page.dart';
import 'package:family_pet/resources/personal_profiles/views/profiles_page.dart';
import 'package:family_pet/resources/pick_media/views/pick_media_page.dart';
import 'package:family_pet/resources/register_pet/views/register_pet_page.dart';
import 'package:family_pet/resources/signin/views/signin_page.dart';
import 'package:family_pet/resources/signup/views/signup_page.dart';
import 'package:family_pet/resources/top_page/top_screen.dart';
import 'package:family_pet/resources/welcome/views/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'general/app_strings/app_strings.dart';

SharedPreferences? prefs;
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// // Firebase local notification plugin
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
// //Firebase messaging
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageCubit cubit = LanguageCubit();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializing();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
        create: (BuildContext context) => cubit,
        child: BlocBuilder<LanguageCubit, LanguageState>(
            bloc: cubit,
            builder: (BuildContext context, LanguageState state) {
              if (state is LanguageInitial) {
                return MaterialApp(
                  title: 'Family Pet',
                  debugShowCheckedModeBanner: false,
                  locale: Locale(state.locale, ''),
                  supportedLocales: const <Locale>[
                    Locale('ja', ''),
                    Locale('vi', ''),
                  ],
                  onGenerateRoute: (RouteSettings settings) =>
                      routeSettings(settings),
                  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                    AppLocalizationDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback:
                      (Locale? locale, Iterable<Locale> supportedLocales) {
                    for (final Locale supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                              locale?.languageCode &&
                          supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    return supportedLocales.last;
                  },
                  theme: AppThemeData.lightTheme,
                  // home: InvitationPage(
                  //   userId: 4,
                  //   typeShare: 'Family',
                  //   url: 'invitation/5/Family/1637652986603',
                  // ),
                  initialRoute: RoutesName.welcomePage,
                );
              } else
                return Container();
            }));
  }

  MaterialPageRoute<dynamic> routeSettings(RouteSettings settings) {
    final dynamic data = settings.arguments;
    final Uri uri = Uri.parse(settings.name!);
    if (uri.pathSegments.length == 4 &&
        uri.pathSegments.first == RoutesName.invitationPage) {
      final int id = int.parse(uri.pathSegments[1]);
      final String permission = uri.pathSegments[2];
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => InvitationPage(
          userId: id,
          typeShare: permission,
          url: settings.name!,
        ),
        settings: const RouteSettings(name: RoutesName.invitationPage),
      );
    }
    switch (settings.name) {
      case RoutesName.welcomePage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const WelcomePage(),
          settings: const RouteSettings(name: RoutesName.welcomePage),
        );
      case RoutesName.addAPicture:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const AddAPicturePage(),
          settings: const RouteSettings(name: RoutesName.addAPicture),
        );
      case RoutesName.registerFastUserPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const RegisterFastUserPage(),
          settings: const RouteSettings(name: RoutesName.registerFastUserPage),
        );
      case RoutesName.imageDetails:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              ImageDetailsPage(media: data[Constant.media] as Media),
          settings: const RouteSettings(name: RoutesName.imageDetails),
        );
      case RoutesName.interestsPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const InterestsPage(),
          settings: const RouteSettings(name: RoutesName.interestsPage),
        );
      case RoutesName.introducePage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const IntroducePage(),
          settings: const RouteSettings(name: RoutesName.introducePage),
        );
      case RoutesName.inviteRelativesPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const InviteRelativePage(),
          settings: const RouteSettings(name: RoutesName.inviteRelativesPage),
        );
      case RoutesName.listRelativesPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ListRelativesPage(
            friends: data[Constant.friends] as List<UserInfo>,
            familyMembers: data[Constant.familyMembers] as List<UserInfo>,
          ),
          settings: const RouteSettings(name: RoutesName.listRelativesPage),
        );
      case RoutesName.newsPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const NewsPage(),
          settings: const RouteSettings(name: RoutesName.newsPage),
        );
      case RoutesName.profilePage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const ProfileViewPage(),
          settings: const RouteSettings(name: RoutesName.profilePage),
        );
      case RoutesName.pickMediaPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const PickMediaPage(),
          settings: const RouteSettings(name: RoutesName.profilePage),
        );
      case RoutesName.registerPet:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => RegisterPetPage(
            isFirstStep: data[Constant.isFirstStep] as bool,
          ),
          settings: const RouteSettings(name: RoutesName.registerPet),
        );
      case RoutesName.signUpPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => SignUpPage(
            userInfo: data[Constant.userInfo] as UserInfo,
          ),
          settings: const RouteSettings(name: RoutesName.signUpPage),
        );
      case RoutesName.signInPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SignInPage(),
          settings: const RouteSettings(name: RoutesName.signInPage),
        );
      case RoutesName.topPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const TopScreenPage(),
          settings: const RouteSettings(name: RoutesName.topPage),
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const DefaultPage(),
          settings: const RouteSettings(name: RoutesName.defaultPage),
        );
    }
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

    final String? token = await firebaseMessaging.getToken();
    // prefs!.setString(Constant.firebaseKey, token);
    print('Token =============== $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      onMessage(remoteMessage.data, notificationDetails);
    });

    // firebaseMessaging.configure(
    //   onLaunch: (Map<String, dynamic> msg) async {
    //     print('on Launch ' + json.encode(msg));
    //   },
    //   onMessage: (Map<String, dynamic> msg) =>
    //
    //   onResume: (Map<String, dynamic> msg) async {
    //     print('on Resume ' + json.encode(msg));
    //   },
    // );
  }
}



Future<void> onMessage(Map<String, dynamic> msg,
    NotificationDetails platformChannelSpecifics) async {
  print('onMessage $msg');

  try {
    // NotificationEntity notification;
    if (Platform.isAndroid) {
      final Map<String, dynamic> data =
      jsonDecode(msg[Constant.data] as String) as Map<String, dynamic>;
      // notification = NotificationEntity.fromMap(data);
    } else if (Platform.isIOS) {
      final Map<String, dynamic> data =
      jsonDecode(msg[Constant.data] as String) as Map<String, dynamic>;
      // notification = NotificationEntity.fromMap(
      //     json.decode(json.encode(data)) as Map<String, dynamic>);
    }

    flutterLocalNotificationsPlugin.show(
      msg['data']['id'] as int ,
      msg['data']['title'] as String,
      msg['data']['body'] as String,
      platformChannelSpecifics,
    );
  } catch (error) {
    flutterLocalNotificationsPlugin.show(
      0,
      'Thông báo',
      'Bạn vừa nhận được một thông báo mới',
      platformChannelSpecifics,
    );
    print('Notification Error => $error ');
  }
}
