import 'package:flutter/material.dart';
import '../app_colors.dart';

class ConstructorTextStyle {
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w500,
  );
  static TextStyle cost = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w200,
    color: Colors.white,
  );

  static const TextStyle inputText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle appBar = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.greenColor);

  static const TextStyle lable = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
