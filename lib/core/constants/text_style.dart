import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/app_colors.dart';


@immutable
class TextStyles {
  static const h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    fontFamily: 'Montserrat',
  );

  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Nerko One',
  );

  static const h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const subtitleText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

    static const nerko = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Nerko One',
  );

  static const large = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  static const medium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
}

