import 'package:bazzar/features/myaccount/widget/bottom_navigation_bar_myaddress_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';

import 'add_address_screen.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          const AppBarProfileScreen(),
          verticalSpace(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Text(
                  "My Address",
                  style: TextStyle(
                    color: ColorsManager.darkBlue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('addresses').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error fetching addresses"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final addresses = snapshot.data!.docs;

                if (addresses.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_off,
                        size: 100.w,
                        color: ColorsManager.darkBlue,
                      ),
                      verticalSpace(10),
                      Text(
                        "No Address Available !",
                        style: TextStyle(
                          color: ColorsManager.darkBlue,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(10),
                      Text(
                        "Please Add New address",
                        style: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address =
                        addresses[index].data() as Map<String, dynamic>;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    address['addressName'] ?? 'No Name',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorsManager.darkBlue,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.grey),
                                    onPressed: () async {
                                      final confirm = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              "Delete Address",
                                              style: TextStyle(
                                                  color:
                                                      ColorsManager.darkBlue),
                                            ),
                                          ),
                                          content: SizedBox(
                                            height: 50.h,
                                            width: 10000.w,
                                            child: const Center(
                                              child: Text(
                                                  "Are you sure you want to delete this address?"),
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
                                                        Size(120.w, 50.h),
                                                    backgroundColor:
                                                        Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 30.w,
                                                      vertical: 10.h,
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: ColorsManager
                                                            .darkBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.w),
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
                                                        Size(120.w, 50.h),
                                                    backgroundColor:
                                                        Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 30.w,
                                                      vertical: 10.h,
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: ColorsManager
                                                            .darkBlue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.w),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm == true) {
                                        try {
                                          await _firestore
                                              .collection('addresses')
                                              .doc(addresses[index].id)
                                              .delete();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Address deleted successfully"),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Error: ${e.toString()}"),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                              verticalSpace(5),
                              Text(
                                address['country'] ?? '',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF464646)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${address['governorate'] ?? ''}"
                                    "\n${address['addressName'] ?? ''}, "
                                    "${address['houseNumber'] ?? ''}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xFF464646)),
                                  ),
                                  MaterialButton(
                                    minWidth: 45.w,
                                    height: 35.h,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddAddressScreen(
                                            addressData: address,
                                            documentId: addresses[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    color: ColorsManager.darkBlue,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Text(
                                      "EDIT",
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (address['addressName'] != null &&
                                  address['addressName'].isNotEmpty)
                                Text(
                                  "Floor: ${address['floorNumber']}",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF464646)),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const BottomNavigationBarMyaddressScreen(),
        ],
      ),
    );
  }
}
