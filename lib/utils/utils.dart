import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

String getTimeAgo(DateTime publishDate) {
  DateTime currentDate = DateTime.now();
  final difference = currentDate.difference(publishDate);
  if (difference.inSeconds < 60) {
    return 'Только что';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} мин. назад';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} час. назад';
  } else {
    String month = '';
    switch (publishDate.month) {
      case 1:
        month = 'янв.';
        break;
      case 2:
        month = 'фев..';
        break;
      case 3:
        month = 'мар.';
        break;
      case 4:
        month = 'апр.';
        break;
      case 5:
        month = 'мая';
        break;
      case 6:
        month = 'июн.';
        break;
      case 7:
        month = 'июл.';
        break;
      case 8:
        month = 'авг.';
        break;
      case 9:
        month = 'сен.';
        break;
      case 10:
        month = 'окт.';
        break;
      case 11:
        month = 'ноя.';
        break;
      case 12:
        month = 'дек.';
        break;
    }
    return '${publishDate.day} $month';
  }
}
