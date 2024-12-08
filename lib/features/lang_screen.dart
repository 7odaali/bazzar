/*
import 'package:bazzar/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theming/styles.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: SafeArea(
          child: Column(
            children: [
              verticalSpace(50),
              Center(
                child: Image.asset(
                  "assets/LOGO1.png",
                  height: 120.h,
                ),
              ),
              verticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Choose Language",
                    style: TextStyles.font22boldDarkBlue
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Please Choose your Language",
                    style: TextStyles.font15boldDarkBlue.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  setState(() {
                    selectedLanguage = 'English';
                  });
                },
                color: selectedLanguage == 'English'
                    ? Colors.yellow
                    : Colors.white,
                minWidth: double.infinity,
                height: 45.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "English",
                      style: TextStyle(
                          fontSize: 14.w, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 17.w,
                    )
                  ],
                ),
              ),
              verticalSpace(20),
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  setState(() {
                    selectedLanguage = 'العربية';
                  });
                },
                color: selectedLanguage == 'العربية'
                    ? Colors.yellow
                    : Colors.white,
                minWidth: double.infinity,
                height: 45.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "العربية",
                      style: TextStyle(
                          fontSize: 14.w, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 17.w,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/helpers/spacing.dart';
import '../core/theming/styles.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: SafeArea(
          child: Column(
            children: [
              verticalSpace(50),
              Center(
                child: Image.asset(
                  "assets/LOGO1.png",
                  height: 120.h,
                ),
              ),
              verticalSpace(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'choose_language'.tr(),
                    style: TextStyles.font22boldDarkBlue
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              verticalSpace(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'please_choose_language'.tr(),
                    style: TextStyles.font15boldDarkBlue.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  setState(() {
                    context.setLocale(const Locale('en'));
                  });
                },
                color: context.locale.languageCode == 'en'
                    ? Colors.yellow
                    : Colors.white,
                minWidth: double.infinity,
                height: 45.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'english'.tr(),
                      style: TextStyle(
                        fontSize: 14.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 17.w,
                    )
                  ],
                ),
              ),
              verticalSpace(20),
              MaterialButton(
                elevation: 0,
                onPressed: () {
                  setState(() {
                    context.setLocale(const Locale('ar'));
                  });
                },
                color: context.locale.languageCode == 'ar'
                    ? Colors.yellow
                    : Colors.white,
                minWidth: double.infinity,
                height: 45.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'arabic'.tr(),
                      style: TextStyle(
                        fontSize: 14.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 17.w,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
