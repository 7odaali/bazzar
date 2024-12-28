import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../cart/cubit/cart_cubit.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({super.key, required this.orderData});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.orderData;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
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
                      height: 350.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(10),
                            Text(
                              "Shipping Address",
                              style: TextStyle(
                                  color: const Color(0xFF464646),
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.bold),
                            ),
                            verticalSpace(8),
                            Text(
                              "${data['country'] ?? "Egypt"} \n${data['governorate'] ?? "Cairo"} \n${data['address_details'] ?? "PARK,22"} buildnumber, floor ${data['floor'] ?? "1"} .",
                              style: TextStyle(
                                  color: ColorsManager.darkBlue,
                                  fontSize: 13.w,
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
/*
                                MaterialButton(
                                  minWidth: 180.w,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.w),
                                    ),
                                  ),
                                  height: 55.h,
                                  color: Colors.yellow,
                                  onPressed: () {
                                    final orderId = data['order_id'];
                                    if (orderId != null) {
                                      context
                                          .read<CartCubit>()
                                          .deleteOrder(orderId);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Order deleted successfully!',
                                          ),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    "Cancelled",
                                    style: TextStyle(
                                        fontSize: 19.w,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.darkBlue),
                                  ),
                                ),
*/
                                MaterialButton(
                                  minWidth: 180.w,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.w),
                                    ),
                                  ),
                                  height: 55.h,
                                  color: Colors.yellow,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.w)),
                                          title: const Center(
                                            child: Text('Confirm Cancellation'),
                                          ),
                                          content: SizedBox(
                                            height: 50.h,
                                            child: const Center(
                                              child: Text(
                                                  'Are you sure you want to cancel this order?'),
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    minimumSize:
                                                        Size(110.w, 50.h),
                                                    backgroundColor:
                                                        Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 30.w,
                                                      vertical: 10.h,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: ColorsManager
                                                            .darkBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.w),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    minimumSize:
                                                        Size(110.w, 50.h),
                                                    backgroundColor:
                                                        Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 30.w,
                                                      vertical: 10.h,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    final orderId =
                                                        data['order_id'];
                                                    if (orderId != null) {
                                                      context
                                                          .read<CartCubit>()
                                                          .deleteOrder(orderId);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                              'Order deleted successfully!'),
                                                        ),
                                                      );
                                                      Navigator.pop(
                                                          context); // Close the current screen
                                                    }
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: ColorsManager
                                                            .darkBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.w),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Cancelled",
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
                                  (data['created_at'] as Timestamp)
                                      .toDate()
                                      .toString()
                                      .split(' ')[0],
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
                                  data['order_id'] ?? "",
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
                                  "Products Total",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                                Text(
                                  "\$${data['total_price']}",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.w),
                                ),
                              ],
                            ),
                            verticalSpace(8),
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
                  verticalSpace(16),
                  Column(
                    children: [
                      for (var item in data['items'])
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              item['image'] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Image.network(
                                        item['image'],
                                        height: 50.h,
                                        width: 50.w,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.error,
                                      size: 20.w,
                                    ),
                              horizontalSpace(10),
                              Expanded(
                                child: Text(
                                  "${item['name']} - \$${item['price']}",
                                  style: TextStyle(
                                      color: ColorsManager.darkBlue,
                                      fontSize: 16.w),
                                ),
                              ),
                            ],
                          ),
                        ),
                      verticalSpace(20),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products Total",
                        style: TextStyle(
                            color: ColorsManager.darkBlue.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.w),
                      ),
                      Text(
                        "\$${data['total_price']}",
                        style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.w),
                      ),
                    ],
                  ),
                  verticalSpace(66),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
