import 'package:bazzar/features/myaccount/widget/bottom_navigation_bar_myaddress_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';

import '../cart/cubit/cart_cubit.dart';
import 'add_address_screen.dart';

class MyAddressScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const MyAddressScreen({super.key, required this.cartItems});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String? selectedAddress;
  String? selectedAddressCountry;
  String? selectedAddressGovernorate;
  String? selectedAddressDetails;
  String? selectedAddressFloor;

  @override
  void initState() {
    super.initState();
    _loadSelectedAddress();
  }

  Future<void> _loadSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAddress = prefs.getString('selectedAddress');
      selectedAddressCountry = prefs.getString('selectedAddressCountry');
      selectedAddressGovernorate =
          prefs.getString('selectedAddressGovernorate');
      selectedAddressDetails = prefs.getString('selectedAddressDetails');
      selectedAddressFloor = prefs.getString('selectedAddressFloor');
    });
  }

  Future<void> _saveSelectedAddress(String address, String country,
      String governorate, String addressDetails, String floor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAddress', address);
    await prefs.setString('selectedAddressCountry', country);
    await prefs.setString('selectedAddressGovernorate', governorate);
    await prefs.setString('selectedAddressDetails', addressDetails);
    await prefs.setString('selectedAddressFloor', floor);
  }

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
              stream: _fireStore.collection('addresses').snapshots(),
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
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
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
                                        Row(
                                          children: [
                                            Radio<String>(
                                              activeColor:
                                                  const Color(0xFF041A31),
                                              value: address['addressName'] ??
                                                  'No Name',
                                              groupValue: selectedAddress,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedAddress = value!;
                                                  selectedAddressCountry =
                                                      address['country'];
                                                  selectedAddressGovernorate =
                                                      address['governorate'];
                                                  selectedAddressDetails =
                                                      "${address['addressName']}, ${address['houseNumber']}";
                                                  selectedAddressFloor =
                                                      address['floorNumber'];
                                                });
                                                _saveSelectedAddress(
                                                  value!,
                                                  address['country'] ?? '',
                                                  address['governorate'] ?? '',
                                                  "${address['addressName'] ?? ''}, ${address['houseNumber'] ?? ''}",
                                                  address['floorNumber'] ?? '',
                                                );
                                              },
                                            ),
                                            Text(
                                              address['addressName'] ??
                                                  'No Name',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsManager.darkBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.grey),
                                          onPressed: () async {
                                            final confirm = await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.w)),
                                                title: Center(
                                                  child: Text(
                                                    "Delete Address",
                                                    style: TextStyle(
                                                        fontSize: 11.w,
                                                        color: ColorsManager
                                                            .darkBlue),
                                                  ),
                                                ),
                                                content: SizedBox(
                                                  height: 50.h,
                                                  width: 10000.w,
                                                  child: Center(
                                                    child: Text(
                                                      "Are you sure you want to delete this address?",
                                                      style: TextStyle(
                                                          fontSize: 9.w),
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          minimumSize:
                                                              Size(120.w, 50.h),
                                                          backgroundColor:
                                                              Colors.yellow,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30.w,
                                                                  vertical:
                                                                      10.h),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false),
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                                  ColorsManager
                                                                      .darkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15.w),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          minimumSize:
                                                              Size(120.w, 50.h),
                                                          backgroundColor:
                                                              Colors.yellow,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30.w,
                                                                  vertical:
                                                                      10.h),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true),
                                                        child: Text(
                                                          "Delete",
                                                          style: TextStyle(
                                                              color:
                                                                  ColorsManager
                                                                      .darkBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                await _fireStore
                                                    .collection('addresses')
                                                    .doc(addresses[index].id)
                                                    .delete();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Address deleted successfully"),
                                                    backgroundColor:
                                                        Colors.green,
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 45.w),
                                      child: Text(
                                        address['country'] ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF464646),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 45.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${address['governorate'] ?? ''}\n${address['addressName'] ?? ''}, ${address['houseNumber'] ?? ''}",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xFF464646),
                                            ),
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
                                                    documentId:
                                                        addresses[index].id,
                                                  ),
                                                ),
                                              );
                                            },
                                            color: ColorsManager.darkBlue,
                                            textColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Text(
                                              "EDIT",
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (address['addressName'] != null &&
                                        address['addressName'].isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(left: 45.w),
                                        child: Text(
                                          "Floor: ${address['floorNumber']}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: const Color(0xFF464646),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: MaterialButton(
                        minWidth: 1000.w,
                        height: 50.h,
                        onPressed: () async {
                          if (widget.cartItems.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cart is empty!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (selectedAddress == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please select an address first!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          final orderData = {
                            'items': widget.cartItems,
                            'address': selectedAddress,
                            'country': selectedAddressCountry ?? '',
                            'governorate': selectedAddressGovernorate ?? '',
                            'address_details': selectedAddressDetails ?? '',
                            'floor': selectedAddressFloor ?? '',
                            'total_price': widget.cartItems.fold<double>(
                              0.0,
                              (sum, item) =>
                                  sum +
                                  (double.tryParse(item['price'].toString()) ??
                                      0.0),
                            ),
                            'created_at': FieldValue.serverTimestamp(),
                          };

                          try {
                            final docRef = await FirebaseFirestore.instance
                                .collection('orders')
                                .add(orderData);
                            await docRef.update({'order_id': docRef.id});

                            context.read<CartCubit>().emit([]);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order created successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error creating order: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        color: ColorsManager.darkBlue,
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0.w),
                        ),
                        child: Text(
                          'Create Order',
                          style: TextStyle(
                              fontSize: 19.w, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
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
