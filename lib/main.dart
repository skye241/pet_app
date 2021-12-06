import 'dart:convert';
import 'dart:io';

import 'package:family_pet/general/app_theme_date.dart';
import 'package:family_pet/general/constant/constant.dart';
import 'package:family_pet/general/constant/routes_name.dart';
import 'package:family_pet/model/entity.dart';
import 'package:family_pet/resources/add_a_picture/views/add_a_picture_page.dart';
import 'package:family_pet/resources/default_page/default_page.dart';
import 'package:family_pet/resources/edit_account/edit_account_view.dart';
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
import 'package:family_pet/resources/term_page/term_page.dart';
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
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
  //       appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
  //       messagingSenderId: '448618578101',
  //       projectId: 'react-native-firebase-testing',
  //     ));
  final List<String> notificationList =
      prefs!.getStringList(Constant.notificationList) ?? <String>[];
  Comment notification = Comment();
  if (Platform.isAndroid) {
    notification = Comment.fromMap(msg.data);
  } else if (Platform.isIOS) {
    notification = Comment.fromMap(
        jsonDecode(jsonEncode(msg.data)) as Map<String, dynamic>);
  }
  notification =
      notification.copyWith(createdDate: DateTime.now().millisecondsSinceEpoch);
  notificationList.add(jsonEncode(notification.toMap()));
  prefs!.setStringList(Constant.notificationList, notificationList);
  print('Handling a background message ${msg.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
        create: (BuildContext context) => cubit,
        child: BlocBuilder<LanguageCubit, LanguageState>(
            bloc: cubit,
            builder: (BuildContext context, LanguageState state) {
              if (state is LanguageInitial) {
                print('reload state');
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
                        // cubit.initLocale(supportedLocale.languageCode);

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
        case RoutesName.editAccountPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => EditAccountPage(
            userInfo: data[Constant.userInfo] as UserInfo,
          ),
          settings: const RouteSettings(name: RoutesName.signUpPage),
        );
      case RoutesName.signInPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SignInPage(),
          settings: const RouteSettings(name: RoutesName.signInPage),
        );
      case RoutesName.termPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) =>
              TermPage(termType: data[Constant.termType] as int),
          settings: const RouteSettings(name: RoutesName.termPage),
        );
      case RoutesName.topPage:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => TopScreenPage(
            index: data != null ? data[Constant.index] as int? : null,
          ),
          settings: const RouteSettings(name: RoutesName.topPage),
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const DefaultPage(),
          settings: const RouteSettings(name: RoutesName.defaultPage),
        );
    }
  }
}
