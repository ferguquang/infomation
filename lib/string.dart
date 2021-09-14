import 'package:flutter/material.dart';

extension StringExtension on String {
  get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }

  // String getFirstChar() {
  //   return (this[0] ?? "").toLowerCase();
  // }

  bool get isNullOrEmpty {
    return (this == null || this.isEmpty);
  }

  bool get isNotNullOrEmpty {
    return !this.isNullOrEmpty;
  }

  Color toColor() {
    if (this.isNullOrEmpty) {
      return Color(int.parse("0xffffff"));
    }
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Color(int.parse("0xffffff"));
  }
  // regex for email
  bool isEmail() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  // regex for phone
  bool isPhone() {
    return RegExp(r"^[0-9]{10,11}$").hasMatch(this);
  }
}