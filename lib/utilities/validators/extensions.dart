import 'package:flutter/material.dart';
import 'package:ielts/utilities/constants/assets_path.dart';
import 'package:intl/intl.dart';

extension ColorExtension on num? {
  Color getColorFromRange() {
    if (this! >= 0 && this! <= 3) {
      return Colors.red;
    } else if (this! > 3 && this! <= 5) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}

extension EmojiExtension on num? {
  String getEmojiFromRange() {
    if (this! >= 0 && this! <= 2) {
      return '☹️';
    } else if (this! > 2 && this! <= 4) {
      return '😐'; // Neutral face emoji for medium range
    } else if (this! > 4 && this! <= 7) {
      return '🙂'; // Slightly smiling face emoji for happy range
    } else {
      return '😃'; // Big smiling face emoji for very happy range
    }
  }
}

String getIconPath({required String fileName}) {
  final ext = fileName.split('.');
  final extension = ext.last;
  switch (extension.toLowerCase()) {
    case 'docx':
      return AssetPath.word;
    case 'jpeg':
      return AssetPath.image;
    case 'jpg':
      return AssetPath.image;
    case 'pdf':
      return AssetPath.file;
    case 'ods':
      return AssetPath.file;
    case 'odt':
      return AssetPath.file;
    case 'png':
      return AssetPath.image;
    case 'ppt':
      return AssetPath.ppt;
    case 'pptx':
      return AssetPath.ppt;
    case 'rar':
      return AssetPath.file;
    case 'tar':
      return AssetPath.file;
    case 'xls':
      return AssetPath.excel;
    case 'xlsx':
      return AssetPath.excel;
    case 'txt':
      return AssetPath.file;
    case 'zip':
      return AssetPath.file;
    default:
      return AssetPath.file; // Default icon for unknown extensions
  }
}



String getDayOfWeek(String dateString) {
  DateTime date = DateTime.parse(dateString);
  String dayOfWeek = DateFormat('EEEE').format(date);
  return dayOfWeek;
}

String getTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String time = DateFormat('HH:mm').format(dateTime);
  return time;
}

String classEndDate(String timeString, num minutesToAdd) {
  DateTime time = DateFormat('HH:mm').parse(timeString);
  DateTime newTime = time.add(Duration(minutes: minutesToAdd.toInt()));
  String formattedTime = DateFormat('HH:mm').format(newTime);
  return formattedTime;
}
String getCurrentDay() {
  DateTime now = DateTime.now();
  int day = now.day;
  String dayString = day.toString().padLeft(2, '0');
  return dayString;
}
