import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'font_weight.dart';

class TextStyles {
  static TextStyle font22boldDarkBlue = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font17boldDarkBlue = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font15boldDarkBlue = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.darkBlue,
  );


  static TextStyle font15RegularLightGray = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.lightGray,
  );
  static TextStyle font16RegularGray = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.gray,
  );


  static TextStyle font20boldYellow = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.yellow,
  );
  static TextStyle font20boldDarkWhite = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.darkWhite,
  );
}
