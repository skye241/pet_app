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
import 'package:family_pet/resources/list_of_relatives/views/list_relatives_page.dart';
import 'package:family_pet/resources/news/views/news_page.dart';
import 'package:family_pet/resources/personal_profiles/views/profiles_page.dart';
import 'package:family_pet/resources/pick_media/views/pick_media_page.dart';
import 'package:family_pet/resources/register_pet/views/register_pet_page.dart';
import 'package:family_pet/resources/signin/views/signin_page.dart';
import 'package:family_pet/resources/top_page/top_screen.dart';
import 'package:family_pet/resources/welcome/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'general/app_strings/app_strings.dart';

SharedPreferences? prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Locale locale = const Locale('vi', '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Pet',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const <Locale>[
        Locale('en', ''),
        Locale('vi', ''),
      ],
      onGenerateRoute: (RouteSettings settings) => routeSettings(settings),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        for (final Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: AppThemeData.lightTheme,
      initialRoute: RoutesName.welcomePage,
    );
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
          builder: (BuildContext context) => ListRelativesPage(),
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
          builder: (BuildContext context) => const RegisterPetPage(),
          settings: const RouteSettings(name: RoutesName.registerPet),
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
}
