import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/general/app_theme_date.dart';
import 'package:flutter/material.dart';

class AlbumEmptyFragment extends StatelessWidget {
  const AlbumEmptyFragment({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/img_album.png',
          width: 223,
          height: 198,
        ),
        const SizedBox(
          height: 16,
        ),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              height: 1.5,
              color: AppThemeData.color_black_80),
        ),
        // Text(
        //   style: const TextStyle(
        //       fontWeight: FontWeight.w400,
        //       fontSize: 16,
        //       height: 1.5,
        //       color: AppThemeData.color_black_80),
        // ),
      ],
    );
  }
}
