import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/add_a_picture/views/add_a_picture_page.dart';
import 'package:family_pet/resources/fast_register_user/views/register_fast_user_page.dart';
import 'package:family_pet/resources/signup/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'genaral/app_strings/app_strings.dart';
import 'resources/register_pet/views/register_pet_page.dart';


SharedPreferences? prefs;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Locale locale =  const Locale('vi','');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Pet',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const <Locale>[
        Locale('en',''),
        Locale('vi',''),
      ],
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        for (final Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: AppThemeData.lightTheme,
      home: const RegisterFastUserPage(),
    );
  }
}


