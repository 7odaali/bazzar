import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../login/login_screen.dart';
import '../../request/my_requests_screen.dart';
import '../add_address_screen.dart';
import '../change_password_screen.dart';
import '../my_address_screen.dart';
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAddressScreen(
                        cartItems: List<Map<String, dynamic>>.from(
                            context.read<CartCubit>().state),
                      ),
                    ),
                  );
                },
                child: Row(
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
                          height: 200.h,
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
                                   Expanded(
                                    child: Text(
                                      "For each 10 KWD you spend you will gain 1 PT",
                                      style: TextStyle(color: Colors.grey,fontSize: 10.w),
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
                                   Expanded(
                                    child: Text(
                                      "For redeeming 10 PT = 1 KWD",
                                      style: TextStyle(color: Colors.grey,fontSize: 10.w),
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
                                   Expanded(
                                    child: Text(
                                      "Bazzar Points are available for Kuwait ONLY.",
                                      style: TextStyle(color: Colors.grey,fontSize: 10.w),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
                child: Row(
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
              ),
              GestureDetector(
                onTap: () async {
                  bool? shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        title:  Center(
                          child: Text(
                            "Confirm Logout",
                            style: TextStyle(fontSize: 17.w,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.darkBlue,
                            ),
                          ),
                        ),
                        content: SizedBox(
                          width: 1000.w,
                          height: 90.h,
                          child: const Center(
                            child: Text("Are you sure you want to log out?"),
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size(120.w, 50.h),
                                  backgroundColor: ColorsManager.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size(120.w, 50.h),
                                  backgroundColor: ColorsManager.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.w),
                                  ),
                                ),
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout == true) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Row(
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
                            fontSize: 15.w,
                          ),
                        ),
                      ],
                    ),
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
