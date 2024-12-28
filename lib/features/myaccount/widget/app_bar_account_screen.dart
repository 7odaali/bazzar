import 'package:bazzar/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theming/colors.dart';
import '../../cart/cart_screen.dart';

class AppBarAccountScreen extends StatefulWidget {
  const AppBarAccountScreen({super.key});

  @override
  State<AppBarAccountScreen> createState() => _AppBarAccountScreenState();
}

class _AppBarAccountScreenState extends State<AppBarAccountScreen> {
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
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CartScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          verticalSpace(25)
        ],
      ),
    );
  }
}
