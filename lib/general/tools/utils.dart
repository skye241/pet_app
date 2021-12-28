import 'package:family_pet/general/app_strings/app_strings.dart';
import 'package:family_pet/model/enum.dart';
import 'package:flutter/material.dart';

import '../app_theme_date.dart';

void showPopUpLoading(BuildContext context, {Color? color}) {
  showGeneralDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Loading',
      pageBuilder: (BuildContext context, Animation<dynamic> animation1,
          Animation<dynamic> animation2) {
        return AlertDialog(
          // backgroundColor: Colors.transparent,
          insetPadding:
              EdgeInsets.all(MediaQuery.of(context).size.width / 2 - 48),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        color ?? AppThemeData.color_primary_90),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation1,
          Animation<double> animation2, Widget child) {
        final double curvedValue =
            Curves.easeInOutBack.transform(animation1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: child,
        );
      });
}

void showMessage(BuildContext context, String title, String message,
    {Widget? actions}) {
  showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            actions ??
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        primary: AppThemeData.color_primary_90,
                        fixedSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppStrings.of(context).close,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ))
          ],
        );
      });
}

void showSuccessMessage(BuildContext context, String title, String message,
    {Widget? actions, VoidCallback? afterPop}) {
  Future<dynamic>.delayed(const Duration(seconds: 1), () {
    Navigator.pop(context);
    if (afterPop != null) {
      afterPop();
    }
  });
  showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[actions ?? Container()]);
      });
}

String permissionToText(BuildContext context, String permission) {
  switch (permission) {
    case PermissionPickMedia.family:
      return AppStrings.of(context).textPickMediaButtonFamily;
    case PermissionPickMedia.friend:
      return AppStrings.of(context).textPickMediaButtonFriend;
    case PermissionPickMedia.onlyMe:
      return AppStrings.of(context).textPickMediaButtonOnlyMe;

    default:
      return AppStrings.of(context).textPickMediaButtonFamily;
  }
}
