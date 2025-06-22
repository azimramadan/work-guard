import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/constants/size_config.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle montserratSemiBold16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 16),
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle montserratRegular12(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 12),
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static TextStyle montserratBold16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 16),
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static TextStyle montserratRegular16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 16),
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static TextStyle montserratSemiBold20(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 20),
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle montserratMedium16(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 16),
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle montserratMedium20(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 20),
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle montserratRegular14(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 14),
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static TextStyle montserratSemiBold24(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 24),
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle montserratSemiBold18(BuildContext context) => TextStyle(
    fontSize: getResponsiveFontSize(context, baseFontSize: 18),
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

double getResponsiveFontSize(
  BuildContext context, {
  required double baseFontSize,
}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * baseFontSize;
  double lowerLimit = baseFontSize * .8;
  double upperLimit = baseFontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double screenWidth = MediaQuery.sizeOf(context).width;
  if (screenWidth < SizeConfig.mobileBreakpoint) {
    return screenWidth / 550;
  } else if (screenWidth < SizeConfig.tabletBreakpoint) {
    return screenWidth / 1000;
  } else {
    return screenWidth / 1500;
  }
}
