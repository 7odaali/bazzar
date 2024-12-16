import 'package:bazzar/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../card/cart_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              child: Row(
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
                          builder: (context) => const CartScreen(),
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
            ),
            verticalSpace(20),
            Stack(
              children: [
                SizedBox(
                  height: 300.h,
                  width: 380.w,
                  child: Image.asset(
                    "assets/images/Shape.png",
                  ),
                ),
                Positioned(
                  bottom: 70.h,
                  left: 130.w,
                  child: Column(
                    children: [
                      Text(
                        "Rehbar Raza",
                        style: TextStyle(
                            fontSize: 18.w, fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(1),
                      Text(
                        "user@gmail.com",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorsManager.darkBlue,
                    borderRadius: BorderRadius.circular(30.w)),
                height: 430.h,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline_outlined,
                                size: 20.w,
                                color: Colors.yellow,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/pin (1).png",
                                scale: 1.5,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "My Address",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.square,
                                size: 20.w,
                                color: Colors.yellow,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "My Orders",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.laptop_sharp,
                                size: 20.w,
                                color: Colors.yellow,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "My Requests",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.point_of_sale,
                                size: 20.w,
                                color: Colors.yellow,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "My Points",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline_sharp,
                                size: 20.w,
                                color: Colors.yellow,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "Change Password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.outbond_outlined,
                                size: 20.w,
                                color: Colors.yellow,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.w),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            verticalSpace(50)
          ],
        ),
      ),
    );
  }
}
