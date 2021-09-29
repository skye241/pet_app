import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme_date.dart';

class ComponentHelper {
  static Widget stepByStepHorizontal(
      {int currentStep = 2,
      double? rangeOtherStep,
      double sizePen = 5.0,
      List<Widget>? children,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceAround,
      Color colorDone = const Color(0xff99dd99),
      Color colorWait = const Color(0xffcccccc)}) {
    List<Widget> listChildren = new List.empty(growable: true);
    if (children != null) {
      if (rangeOtherStep != null) {
        for (int i = 0; i < children.length; i++) {
          listChildren.add(children[i]);
          if (i != children.length - 1) {
            listChildren.add(SizedBox(
              width: rangeOtherStep,
            ));
          }
        }
      } else {
        listChildren = children;
      }
    }
    return CustomPaint(
      painter: CustomPaintDrawLineStepHorizontalCenter(
          colorDone: colorDone,
          colorWait: colorWait,
          currentStep: currentStep,
          mainAxisAlignment: mainAxisAlignment,
          sizePen: sizePen,
          totalStep: children?.length),
      child: Row(
        mainAxisSize:
            rangeOtherStep != null ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: mainAxisAlignment,
        children: listChildren,
      ),
    );
  }

  static Widget itemStep({Widget? child, Color? backgroundColor}) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: backgroundColor,
        child: child ?? Container(),
      ),
    );
  }

  static Widget textField(
      {String? label,
      String? hintText,
      String? errorText,
      TextEditingController? controller,
      Widget? suffix}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: suffix,
        labelText: label,
        labelStyle: TextStyle(color: AppThemeData.color_black_40),
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide:
                BorderSide(width: 1, color: AppThemeData.color_black_10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide:
                BorderSide(width: 1, color: AppThemeData.color_black_10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide:
                BorderSide(width: 1, color: AppThemeData.color_black_10)),
      ),
    );
  }

  static Widget borderRadiusImage({Widget? image, double? borderRadius}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: image,
    );
  }

  static Widget radius({
    double? size = 7,
    IconData? iconData = Icons.check,
    Color? backgroundColor = Colors.green,
    double? sizeBorder = 2,
    Color? colorBorder = const Color(0xffffffff),
    Color? colorIcon = const Color(0xffffffff),
    bool? isSelect = false,
    Color? colorBorderDisable = const Color(0xffaaaaaa),
    Color? backgroundColorDisable = Colors.white,
  }) {
    if (isSelect!)
      return CircleAvatar(
        radius: size! + sizeBorder!,
        backgroundColor: colorBorder,
        child: CircleAvatar(
          radius: size,
          backgroundColor: backgroundColor,
          child: Icon(
            iconData,
            size: size + 5,
            color: colorIcon,
          ),
        ),
      );
    else
      return CircleAvatar(
        radius: size! + sizeBorder!,
        backgroundColor: colorBorderDisable,
        child: CircleAvatar(
          radius: size,
          backgroundColor: backgroundColorDisable,
          child: Icon(
            iconData,
            size: size + 5,
            color: colorIcon,
          ),
        ),
      );
  }

  static Widget dropDownButton<T>(List<T> listData, Function(T) onChange) {
    return DropdownButton(
      items: listData
          .map((e) => DropdownMenuItem(child: Text(e.toString())))
          .toList(),

    );
  }

  // static Widget listView

}

class CustomPaintDrawLineStepHorizontalCenter extends CustomPainter {
  CustomPaintDrawLineStepHorizontalCenter({
    this.currentStep = 1,
    this.totalStep,
    this.sizePen = 5.0,
    this.colorDone = const Color(0xff99dd99),
    this.colorWait = const Color(0xffcccccc),
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  Color colorDone;
  Color colorWait;
  int currentStep;
  int? totalStep;
  double sizePen;
  MainAxisAlignment mainAxisAlignment;

  @override
  void paint(Canvas canvas, Size size) {
    if (totalStep != null) {
      Paint paint = new Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = sizePen;
      for (int i = 0; i <= totalStep!; i++) {
        int j = i + 1;
        Offset offset1 = Offset(0, 0);
        Offset offset2 = Offset(0, 0);
        if (mainAxisAlignment == MainAxisAlignment.spaceBetween) {
          if (j < totalStep!) {
            if (j <= currentStep) {
              // Paint done
              paint.color = colorDone;
            } else {
              // Paint line wait
              paint.color = colorWait;
            }
            offset1 = Offset(i * (size.width / (totalStep! - 1)) + sizePen / 2,
                size.height / 2);
            offset2 = Offset(j * (size.width / (totalStep! - 1)) - sizePen / 2,
                size.height / 2);
            canvas.drawLine(offset1, offset2, paint);
          }
        } else {
          if (j <= currentStep) {
            // Paint done
            paint.color = colorDone;
          } else {
            // Paint line wait
            paint.color = colorWait;
          }

          if (mainAxisAlignment == MainAxisAlignment.spaceAround) {
            double rangeUnit = size.width /
                ((totalStep! - 1) * 2 + 2); // for (total -1)*2+2 part
            int addx = i > 0 ? i - 1 : 0;
            offset1 = Offset(i * rangeUnit + addx * rangeUnit, size.height / 2);
            int addy = j == totalStep! + 1 ? j - 2 : j - 1;
            offset2 = Offset(j * rangeUnit + addy * rangeUnit, size.height / 2);
          }
          if (mainAxisAlignment == MainAxisAlignment.spaceEvenly) {
            double rangeUnit =
                size.width / (totalStep! + 1); // for (total -1)*2+2 part
            offset1 = Offset(i * rangeUnit, size.height / 2);
            offset2 = Offset(j * rangeUnit, size.height / 2);
          }
          canvas.drawLine(offset1, offset2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
