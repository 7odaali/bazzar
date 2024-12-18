import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          const AppBarProfileScreen(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: ColorsManager.darkBlue,
                          fontSize: 19.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(30),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name*',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address*',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  verticalSpace(450),
                  MaterialButton(
                    minWidth: 1000.w,
                    height: 50.h,
                    onPressed: () {},
                    color: Colors.yellow,
                    textColor: ColorsManager.darkBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0.w),
                    ),
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 19.w,
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
    );
  }
}
