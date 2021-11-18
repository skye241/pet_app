import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  DateFormatter(this.endDate);

  final DateTime endDate;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex;

    // Get the previous and current input strings
    final String pText = oldValue.text;
    String cText = newValue.text;
    // Abbreviate lengths
    final int cLen = cText.length;
    final int pLen = pText.length;

    // So sánh năm,
    if (cLen == 4 && pLen == 3) {
      if (int.parse(cText.substring(0, 4)) <= endDate.year &&
          int.parse(cText.substring(0, 4)) >= 1900) {
        cText += '-';
      } else
        cText = cText.substring(0, 3);
    }

    // //Thêm 0 vào trước tháng
    // else if (cLen == 6 && pLen == 5) {
    //   if (cText.substring(5, 6) != '0') {
    //     cText = cText.substring(0, 5) + '0' + cText.substring(5, 6);
    //   }
    // }

    // So sánh tháng
    else if (cLen == 7 && pLen == 6) {
      final int year = int.parse(cText.substring(0, 4));
      final int month = int.parse(cText.substring(5, 7));
      if (month <= 12 &&
          month >= 1 &&
          (year < endDate.year ||
              (year == endDate.year && month <= endDate.month))) {

        cText += '-';
      } else
        cText = cText.substring(0, 5) +
            '0' +
            cText.substring(5, 6) +
            '-' +
            cText.substring(6, 7);
    }
    //Thêm 0 vào trước ngày
    else if (cLen == 9 && pLen == 8) {
      cText = cText.substring(0, 8) + '0' + cText.substring(8, 9);
    } else if (cLen == 11 && pLen == 10) {
      final int year = int.parse(cText.substring(0, 4));
      final int month = int.parse(cText.substring(5, 7));
      final int date = int.parse(cText.substring(9, 11));
      final bool currentMonthAndYear =
          year == endDate.year && month == endDate.month;
      if (date > 0 && date <= daysInMonth(month, year)) {
        if ((currentMonthAndYear && date < endDate.day) ||
            !currentMonthAndYear) {
          cText = cText.substring(0, 8) + cText.substring(9, 11);
        } else
          cText = cText.substring(0, 10);
      } else
        cText = cText.substring(0, 10);
    }
    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

int daysInMonth(int month, int year) {
  switch (month) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      return 31;

    case 4:
    case 6:
    case 9:
    case 11:
      return 30;
    case 2:
      if (year % 4 == 0) {
        return 29;
      } else
        return 28;
    default:
      return 30;
  }
}
