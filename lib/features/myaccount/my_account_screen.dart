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
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarAccountScreen(),
            verticalSpace(20),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No data found.'));
                }

                var userData = snapshot.data!;
                String username = userData['username'] ?? '';
                String email = user?.email ?? '';

                return Column(
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
                                username.isNotEmpty ? username : '',
                                style: TextStyle(
                                    fontSize: 18.w,
                                    fontWeight: FontWeight.bold),
                              ),
                              verticalSpace(1),
                              Text(
                                email.isNotEmpty ? email : '',
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
                    verticalSpace(50),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
