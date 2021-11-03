import 'package:family_pet/genaral/app_theme_date.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final String? title;
  final VoidCallback? onPressed;
  final Color? disableColor;

  const AppButton(
      {Key? key,
      this.color = AppThemeData.color_primary_90,
      @required this.title,
      @required this.onPressed,
      this.disableColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppThemeData.color_black_40)),
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            title ?? '',
          ),
        ));
  }
}
