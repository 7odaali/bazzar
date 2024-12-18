import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theming/colors.dart';


class AddAddressScreen extends StatefulWidget {
  final Map<String, dynamic>? addressData;
  final String? documentId;

  const AddAddressScreen({super.key, this.addressData, this.documentId});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _addressNameController;
  late TextEditingController _governorateController;
  late TextEditingController _blockController;
  late TextEditingController _streetController;
  late TextEditingController _houseNumberController;
  late TextEditingController _floorNumberController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _addressNameController =
        TextEditingController(text: widget.addressData?['addressName'] ?? '');
    _governorateController =
        TextEditingController(text: widget.addressData?['governorate'] ?? '');
    _blockController =
        TextEditingController(text: widget.addressData?['block'] ?? '');
    _streetController =
        TextEditingController(text: widget.addressData?['street'] ?? '');
    _houseNumberController =
        TextEditingController(text: widget.addressData?['houseNumber'] ?? '');
    _floorNumberController =
        TextEditingController(text: widget.addressData?['floorNumber'] ?? '');
    _countryController = TextEditingController(
        text: widget.addressData?['country'] ?? '');
  }

  //function @mahmoud
  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      try {
        final data = {
          "addressName": _addressNameController.text,
          "governorate": _governorateController.text,
          "block": _blockController.text,
          "street": _streetController.text,
          "houseNumber": _houseNumberController.text,
          "floorNumber": _floorNumberController.text,
          "country": _countryController.text,
        };

        if (widget.documentId != null) {
          await FirebaseFirestore.instance
              .collection('addresses')
              .doc(widget.documentId)
              .update(data);
        } else {
          await FirebaseFirestore.instance.collection('addresses').add(data);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Address saved successfully!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to save address: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [const AppBarProfileScreen(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Add Address",
                          style: TextStyle(
                              color: ColorsManager.darkBlue,
                              fontSize: 19.w,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),verticalSpace(20),
                    TextFormField(
                      controller: _countryController,
                      decoration: InputDecoration(
                        labelText: "Country*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 14.w,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Field is required" : null,
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: _addressNameController,
                      decoration: InputDecoration(
                        labelText: "Address Name*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle:
                            TextStyle(color: const Color(0xFF464646), fontSize: 14.w),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Field is required" : null,
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: _governorateController,
                      decoration: InputDecoration(
                        labelText: "Governorate*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 14.w,
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Field is required" : null,
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: _blockController,
                      decoration: InputDecoration(
                        labelText: "Block*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 14.w,
                        ),
                      ),
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: _streetController,
                      decoration: InputDecoration(
                        labelText: "Street*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 14.w,
                        ),
                      ),
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: _houseNumberController,
                      decoration: InputDecoration(
                        labelText: "House Number*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 14.w,
                        ),
                      ),
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: _floorNumberController,
                      decoration: InputDecoration(
                        labelText: "Floor Number(Optional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelStyle: TextStyle(
                          color: const Color(0xFF464646),
                          fontSize: 14.w,
                        ),
                      ),
                    ),
                    verticalSpace(100),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50.h,
                      onPressed: _saveAddress,
                      color: Colors.yellow,
                      textColor: ColorsManager.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Add Address",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
