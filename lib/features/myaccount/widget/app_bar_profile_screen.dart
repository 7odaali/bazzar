import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';

class AppBarProfileScreen extends StatefulWidget {
  const AppBarProfileScreen({super.key});

  @override
  State<AppBarProfileScreen> createState() => _AppBarProfileScreenState();
}

class _AppBarProfileScreenState extends State<AppBarProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only( bottomRight: Radius.circular(30.w),
          bottomLeft: Radius.circular(30.w),),
        color: ColorsManager.darkBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,),
              ),
              SizedBox(
                width: 50.w,
              ),
              Center(
                child: SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: Image.asset(
                    "assets/Logo.png",
                    height: 10.h,
                    width: 10.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              horizontalSpace(140)
            ],
          ),
          verticalSpace(25)
        ],
      ),
    );
  }
}
