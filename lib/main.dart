import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'genaral/app_strings/app_strings.dart';
import 'resources/register_pet/views/register_pet_page.dart';

Future<void> main() async{
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
      home: const RegisterPetPage(),
    );
  }
}


