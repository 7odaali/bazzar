import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../request/my_requests_screen.dart';
import '../my_order_screen.dart';
import '../profile_screen.dart';

class CenterAccountScreen extends StatefulWidget {
  const CenterAccountScreen({super.key});

  @override
  State<CenterAccountScreen> createState() => _CenterAccountScreenState();
}

class _CenterAccountScreenState extends State<CenterAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        decoration: BoxDecoration(
            color: ColorsManager.darkBlue,
            borderRadius: BorderRadius.circular(30.w)),
        height: 430.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  /*showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10.w),
                          ),
                          title: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login First",
                                style: TextStyle(
                                  color:
                                  const Color(0xFF041A31),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.w,
                                ),
                              ),
                            ],
                          ),
                          content: SizedBox(
                            height: 80.h,
                            child: const Center(
                              child: Text(
                                  "You need to login / sign up first to View your account!"),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceAround,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                  child: MaterialButton(
                                    minWidth: 130.w,
                                    color: const Color(
                                        0xFF041A31),
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(10),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Signup",
                                      style: TextStyle(
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                  child: MaterialButton(
                                    minWidth: 130.w,
                                    color: Colors.yellow,
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(10),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color:
                                        Color(0xFF041A31),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      });*/
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
                child: Row(
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyOrderScreen(),
                    ),
                  );
                },
                child: Row(
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
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyRequestsScreen(),
                    ),
                  );
                },
                child: Row(
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
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        title: Column(
                          children: [
                            verticalSpace(20),
                            Text(
                              "Bazzar Points",
                              style: TextStyle(
                                color: const Color(0xFF041A31),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.w,
                              ),
                            ),
                          ],
                        ),
                        content: SizedBox(
                          width: 250.w,
                          height: 160.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14.w,
                                    color: Colors.grey,
                                  ),
                                  horizontalSpace(5.w),
                                  const Expanded(
                                    child: Text(
                                      "For each 10 KWD you spend you will gain 1 PT",
                                      style: TextStyle(color: Colors.grey),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14.w,
                                    color: Colors.grey,
                                  ),
                                  horizontalSpace(5.w),
                                  const Expanded(
                                    child: Text(
                                      "For redeeming 10 PT = 1 KWD",
                                      style: TextStyle(color: Colors.grey),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14.w,
                                    color: Colors.grey,
                                  ),
                                  horizontalSpace(5.w),
                                  const Expanded(
                                    child: Text(
                                      "Bazzar Points are available for Kuwait ONLY.",
                                      style: TextStyle(color: Colors.grey),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                            ],
                          ),
                        ),
                        actions: [
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.w,
                                  vertical: 10.h,
                                ),
                              ),
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: const Color(0xFF041A31),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
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
                            fontSize: 15.w,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "111",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
