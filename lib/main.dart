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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'general/app_strings/app_strings.dart';

SharedPreferences? prefs;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  prefs = await SharedPreferences.getInstance();
  await prefs?.reload();
  final List<String> notificationList =
      prefs!.getStringList(Constant.notificationList) ?? <String>[];
  Map<String, dynamic> data = <String, dynamic>{};
  if (msg.data[Constant.result].runtimeType == String) {
    data =
        jsonDecode(msg.data[Constant.result] as String) as Map<String, dynamic>;
  } else
    data = msg.data[Constant.result] as Map<String, dynamic>;
  Comment notification = Comment();
  if (Platform.isAndroid) {
    notification = Comment.fromMap(data);
  } else if (Platform.isIOS) {
    notification = Comment.fromMap(data);
  }
  // print(getString(Constant.commenter, msg.data) + '==== commenter');
  notification = notification.copyWith(
      createdDate: DateTime.now().millisecondsSinceEpoch,
      userName: getString(Constant.commenter, msg.data));
  final List<Comment> listComment = notificationList
      .map((String noti) =>
          Comment.fromMap(jsonDecode(noti) as Map<String, dynamic>))
      .toList();
  listComment.removeWhere((Comment element) => element.id == notification.id);
  listComment.add(notification);
  prefs!.setStringList(Constant.notificationList,
      listComment.map((Comment e) => jsonEncode(e.toMap())).toList());
  print('Handling a background message ${msg.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  prefs = await SharedPreferences.getInstance();
  await prefs?.reload();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
                  // builder: (context, widget) => ResponsiveWrapper.builder(
                  //   ClampingScrollWrapper.builder(context, widget!),
                  //   defaultScale: true,
                  //   minWidth: 480,
                  //   defaultName: MOBILE,
                  //   breakpoints: [
                  //     ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                  //     ResponsiveBreakpoint.resize(600, name: MOBILE),
                  //     ResponsiveBreakpoint.autoScale(850, name: TABLET),
                  //     ResponsiveBreakpoint.resize(1080, name: DESKTOP),
                  //   ],
                  // ),
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
    print(uri.path + ' ==== uri');


    if (uri.pathSegments.length == 4 &&
        uri.pathSegments.first == RoutesName.invitationPage) {
      final int id = int.parse(uri.pathSegments[1]);
      final String permission = uri.pathSegments[2];
      if (id == prefs!.getInt(Constant.userId)) {
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const TopScreenPage(
           index: 0,
          ),
          settings: const RouteSettings(name: RoutesName.invitationPage),
        );
      }
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
