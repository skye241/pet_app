import 'package:family_pet/genaral/app_strings/app_strings.dart';
import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class NewsEmptyFragment extends StatelessWidget {
  NewsEmptyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/img_notification_empty.png",
            width: 198,
            height: 198,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            AppStrings.of(context).textLabelEmptyNews,
            style: TextStyle(
                fontSize: 24,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppThemeData.color_black_80),
          )
        ],
      ),
    );
  }
}
