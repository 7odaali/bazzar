import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25.w,
                        ),
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
                      SizedBox(
                        width: 40.w,
                      ),
                    ],
                  ),
                  verticalSpace(30),
                ],
              ),
            ),
            verticalSpace(30),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0.w,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Order Details",
                        style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontSize: 19.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 13.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    color: Colors.white,
                    elevation: 2,
                    child: SizedBox(
                      height: 400.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(18),
                            Text(
                              "Shipping Address",
                              style: TextStyle(
                                  color: const Color(0xFF464646),
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpace(8),
                            Text(
                              "Kuwait \nFree Trade Zone Argan Business \nPark, Building 9 Ground Floor",
                              style: TextStyle(
                                  color: ColorsManager.darkBlue,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpace(18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Method",
                                      style: TextStyle(
                                          color: const Color(0xFF464646),
                                          fontSize: 15.w,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ONLINE",
                                      style: TextStyle(
                                          color: ColorsManager.darkBlue,
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                MaterialButton(
                                  minWidth: 180.w,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.w),
                                    ),
                                  ),
                                  height: 55.h,
                                  color: Colors.yellow,
                                  onPressed: () {},
                                  child: Text(
                                    "Delivered",
                                    style: TextStyle(
                                        fontSize: 19.w,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.darkBlue),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Date",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                                Text(
                                  "22/09/2020",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order ID",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                                Text(
                                  "#BZR2345522",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                              ],
                            ),
                            verticalSpace(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transcation Id",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                                Text(
                                  "2244554433223134",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                              ],
                            ),
                            verticalSpace(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment Id",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                                Text(
                                  "2254433223134",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                              ],
                            ),
                            verticalSpace(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Earned Points",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                                Text(
                                  "9",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                              ],
                            ),
                            verticalSpace(18),
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Your Order Summary",
                        style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  verticalSpace(66),

                  MaterialButton(
                    minWidth: 10000.w,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.w),
                      ),
                    ),
                    height: 55.h,
                    color: Colors.yellow,
                    onPressed: () {},
                    child: Text(
                      "Reorder",
                      style: TextStyle(
                          fontSize: 19.w,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.darkBlue),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
