import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:family_pet/resources/album/views/image_details_page.dart';
import 'package:family_pet/resources/introduces/views/introduce_page.dart';
import 'package:family_pet/resources/pick_medias/views/pick_media_page.dart';
import 'package:family_pet/resources/top_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'genaral/app_strings/app_strings.dart';

void main() async{
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final Locale locale = new Locale('vi','');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Pet',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: [
        Locale('en',''),
        Locale('vi',''),
      ],
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: AppThemeData.lightTheme,
      home: TopScreenPage(),
    );
  }
}


