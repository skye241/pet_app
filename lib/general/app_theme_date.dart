import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const Color color_primary_90 = Color(0xff20A547);
  static const Color color_primary_30 = Color(0xffBFEAD0);
  static const Color color_main = Color(0xff20A547);
  static const Color color_error = Color(0xffFB4E4E);
  static const Color color_warning = Color(0xffF6A609);
  static const Color color_successs = Color(0xff2AC769);
  static const Color color_black_100 = Color(0xff25282B);
  static const Color color_black_80 = Color(0xff52575C);
  static const Color color_black_60 = Color(0xffA0A4A8);
  static const Color color_black_40 = Color(0xffCACCCF);
  static const Color color_black_10 = Color(0xffE8E8E8);
  static const Color color_black_5 = Color(0xffF9F9FA);
  static const Color color_grey_2 = Color(0xff4F4F4F);
  static const Color color_grey_3 = Color(0xff999999);
  static const Color color_neutral = Color(0xff666666);
  static const Color color_neutral_25 = Color(0xffECEBED);

  static const InputDecoration inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.only(top: 22),
    isCollapsed: true,
  );

  InputDecoration inputDecorationWithHintText(String? hintText) =>
      InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.only(top: 22),
        isCollapsed: true,
        hintStyle: GoogleFonts.roboto(
            color: color_black_40,
            fontSize: 12,
            height: 1.678,
            fontWeight: FontWeight.w400),
      );

  static ThemeData get lightTheme => ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xffffffff),
            iconTheme: IconThemeData(color: Colors.black.withOpacity(0.54)),
            titleTextStyle: GoogleFonts.roboto(
                color: color_black_80,
                fontWeight: FontWeight.w700,
                fontSize: 28,
                height: 1.5),
            toolbarTextStyle: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 42,
                height: 1.1719),
            elevation: 0.0,
            centerTitle: true),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
              GoogleFonts.roboto(
                  color: color_primary_90,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.1718),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
        ),
        // buttonColor: color_primary_90,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppThemeData.color_black_80;
                } else
                  return Colors.white;
                // Use the component's default.
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppThemeData.color_black_40;
                } else
                  return AppThemeData
                      .color_primary_90; // Use the component's default.
              },
            ),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            textStyle: MaterialStateProperty.all<TextStyle>(
              GoogleFonts.roboto(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.1718),
            ),
          ),
        ),
        primaryTextTheme: TextTheme(
            headline6: GoogleFonts.roboto(
                color: color_black_100,
                fontWeight: FontWeight.w400,
                fontSize: 24,
                height: 1.172)),

        scaffoldBackgroundColor: const Color(0xffffffff),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all<Color>(const Color(0xffffffff)),
          fillColor: MaterialStateProperty.all<Color>(color_main),
        ),
        textTheme: TextTheme(
          bodyText1: GoogleFonts.roboto(
              color: color_black_80,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5),
          bodyText2: GoogleFonts.roboto(
              color: color_neutral,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: 0.5,
              height: 1.1718),
          // text default
          // text field
          subtitle1: GoogleFonts.roboto(
              color: color_black_100,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5),
          subtitle2: GoogleFonts.roboto(
              color: color_black_80,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5),
          button: GoogleFonts.roboto(
              color: color_black_60,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.1718),
          headline1: GoogleFonts.roboto(
              color: color_black_100,
              fontWeight: FontWeight.w700,
              fontSize: 44,
              height: 1.5),
          headline2: GoogleFonts.roboto(
              color: color_black_100, // Tick
              fontWeight: FontWeight.w900,
              fontSize: 24,
              height: 1.5),
          headline3: GoogleFonts.roboto(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: 0.5,
              height: 1.172,
              color: color_grey_2),
          headline4: GoogleFonts.roboto(
              color: color_black_80,
              fontWeight: FontWeight.w700,
              fontSize: 28,
              height: 1.5),
          headline5: GoogleFonts.roboto(
              color: color_black_80,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.5),
          headline6: GoogleFonts.roboto(
              color: color_black_100,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              height: 1.5),
          caption: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.172),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(color: color_primary_90),
            showSelectedLabels: false),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: color_primary_90),
        iconTheme: const IconThemeData(color: color_black_80),
        // platform: TargetPlatform.iOS
      );
}
