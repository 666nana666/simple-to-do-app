import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyle {
  static TextStyle _base({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color color = AppColors.textPrimary,
    double letterSpacing = 0.0,
    double? height,
  }) =>
      GoogleFonts.dmSans(
        fontSize: fontSize * 1.sp,
        letterSpacing: letterSpacing * 1.sp,
        fontWeight: fontWeight,
        height: height,
        color: color,
        textBaseline: TextBaseline.alphabetic,
        locale: const Locale('en', 'EN'),
      );

  static TextTheme mainTextTheme = TextTheme(
    headline1: AppTextStyle.nominalBold40(),
    headline2: AppTextStyle.nominalBold40(),
    headline3: AppTextStyle.nominalBold30(),
    headline4: AppTextStyle.headingBold24(),
    headline5: AppTextStyle.headingBold20(),
    headline6: AppTextStyle.headingBold16(),
    subtitle1: AppTextStyle.headingBold14(),
    subtitle2: AppTextStyle.bodyRegular12(AppColors.grey[700]!),
    bodyText1: AppTextStyle.detailRegular12(),
    bodyText2: AppTextStyle.detailRegular14(),
    caption: AppTextStyle.bodyRegular14(AppColors.grey[700]!),
    button: AppTextStyle.detailMedium16(),
  );

  // ------------- Nominal ------------- //
  static TextStyle nominalBold40([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
        fontSize: 40,
      );

  static TextStyle nominalBold30([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
        height: 1.1,
        fontSize: 30,
      );

  // ------------- Heading ------------- //
  static TextStyle headingBold24([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
        height: 1.35,
        fontSize: 24,
      );

  static TextStyle headingBold34([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
        height: 1.35,
        fontSize: 34,
      );

  static TextStyle headingBold20([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        height: 1.35,
        fontSize: 20,
      );

  static TextStyle headingBold16([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        height: 1.35,
        fontSize: 16,
      );

  static TextStyle headingBold14([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        height: 1.35,
      );

  static TextStyle headingBold13([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w700,
        height: 1.35,
        fontSize: 13,
      );

  // ------------- Body ------------- //
  static TextStyle bodyRegular14([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        letterSpacing: -0.1,
        height: 1.5,
      );

  static TextStyle bodyRegular12([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        letterSpacing: -0.1,
        height: 1.5,
        fontSize: 12,
      );

  // ------------- Detail ------------- //
  static TextStyle detailMedium16([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  static TextStyle detailMedium14([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w500,
      );

  static TextStyle detailMedium12([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      );

  static TextStyle detailRegular16([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontSize: 16,
      );

  static TextStyle detailRegular14([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
      );

  static TextStyle detailRegular12([
    Color color = AppColors.textPrimary,
  ]) =>
      _base(
        color: color,
        fontSize: 12,
      );
}
