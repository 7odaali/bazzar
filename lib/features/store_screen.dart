import 'package:bazzar/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theming/colors.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: ColorsManager.darkBlue,
              ),
              child: Center(
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
            ),
            verticalSpace(30),
            SizedBox(
              height: 700.h,
              child: GridView.builder(
                  /*shrinkWrap: false,physics: const NeverScrollableScrollPhysics(),*/
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w),
                  itemCount: 7,
                  itemBuilder: (context, i) {
                    return Card(
                      child: Column(
                        children: [
                          SizedBox(
                              height: 140.h,
                              child: Image.asset("assets/LOGO1.png")),
                          verticalSpace(20),
                          const Text("name"),
                        ],
                      ),
                    );
                  }),
            ),
            verticalSpace(20)
          ],
        ),
      ),
    );
  }
}
