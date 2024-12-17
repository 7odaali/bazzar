import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import 'order_details_screen.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
            verticalSpace(20),
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
                        "My Orders",
                        style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontSize: 19.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  SizedBox(
                    height: 1000.h,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                            .orderBy('created_at', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Column(
                              children: [
                                verticalSpace(240),
                                Text(
                                  "No orders .....",
                                  style: TextStyle(
                                      fontSize: 22.w,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          }
                          final orders = snapshot.data!.docs;
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: orders.length,
                            itemBuilder: (context, i) {
                              final order = orders[i];
                              final data = order.data() as Map<String, dynamic>;
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 13.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.w)),
                                ),
                                color: Colors.white,
                                elevation: 2,
                                child: SizedBox(
                                  height: 250.h,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.w, vertical: 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.w, vertical: 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              order.id,
                                              style: TextStyle(
                                                  color: ColorsManager.darkBlue
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.w),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.w, vertical: 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Items",
                                              style: TextStyle(
                                                  color: ColorsManager.darkBlue
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.w),
                                            ),
                                            Text(
                                              "${data['items'].length}",
                                              style: TextStyle(
                                                  color: ColorsManager.darkBlue
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.w),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.w, vertical: 8.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0.w, vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MaterialButton(
                                              minWidth: 220.w,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.w),
                                                ),
                                              ),
                                              height: 50.h,
                                              color: Colors.yellow,
                                              onPressed: () {},
                                              child: Text(
                                                "Confirmed",
                                                style: TextStyle(
                                                    fontSize: 18.w,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorsManager.darkBlue),
                                              ),
                                            ),
                                            MaterialButton(
                                              minWidth: 50.w,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.w),
                                                ),
                                              ),
                                              height: 50.h,
                                              color: ColorsManager.darkBlue,
                                              onPressed: () {},
                                              child: const Icon(
                                                Icons.tag_sharp,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                            MaterialButton(
                                              minWidth: 50.w,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.w),
                                                ),
                                              ),
                                              height: 50.h,
                                              color: ColorsManager.darkBlue,
                                              onPressed: () {
                                               /* Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OrderDetailsScreen(),
                                                  ),
                                                );*/Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => OrderDetailsScreen(orderData: data),
                                                  ),
                                                );
                                              },
                                              child: const Icon(
                                                Icons.arrow_forward,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
