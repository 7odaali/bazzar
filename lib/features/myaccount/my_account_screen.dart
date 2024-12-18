import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_account_screen.dart';
import 'package:bazzar/features/myaccount/widget/center_account_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String username = '';
  String email = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc['username'] ?? '';
            email = user.email ?? '';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarAccountScreen(),
            verticalSpace(20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 300.h,
                            width: 380.w,
                            child: Image.asset(
                              "assets/images/Shape.png",
                            ),
                          ),
                          Positioned(
                            bottom: 80.h,
                            left: 100.w,
                            child: Column(
                              children: [
                                Text(
                                  username.isNotEmpty
                                      ? username
                                      : '',
                                  style: TextStyle(
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.bold),
                                ),
                                verticalSpace(1),
                                Text(
                                  email.isNotEmpty
                                      ? email
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const CenterAccountScreen(),
                      verticalSpace(50)
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
