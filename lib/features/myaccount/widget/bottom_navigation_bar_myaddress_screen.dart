import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../add_address_screen.dart';

class BottomNavigationBarMyaddressScreen extends StatefulWidget {
  const BottomNavigationBarMyaddressScreen({super.key});

  @override
  State<BottomNavigationBarMyaddressScreen> createState() => _BottomNavigationBarMyaddressScreenState();
}

class _BottomNavigationBarMyaddressScreenState extends State<BottomNavigationBarMyaddressScreen> {
  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding: EdgeInsets.all(15.w),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 50.h,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ),
          );
        },
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
    )
    ;
  }
}
