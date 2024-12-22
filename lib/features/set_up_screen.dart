import 'package:bazzar/core/theming/colors.dart';
import 'package:bazzar/core/theming/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'onboarding/onboarding_screen.dart';

class SetUpScreen extends StatefulWidget {
  const SetUpScreen({super.key});

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/BG.png",fit: BoxFit.cover,)),
          Positioned(
            right: 0,
            bottom: 30.h,
            child: MaterialButton(
              height: 40.h,
              minWidth: 100.w,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.w),
                  topLeft: Radius.circular(5.w),
                ),
              ),
              color: ColorsManager.darkBlue,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                );
              },
              child: Text(
                "skip".tr(),
                style: TextStyles.font20boldDarkWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}
