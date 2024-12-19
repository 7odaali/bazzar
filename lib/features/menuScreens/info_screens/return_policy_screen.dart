import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../myaccount/widget/app_bar_profile_screen.dart';

class ReturnPolicyScreen extends StatefulWidget {
  const ReturnPolicyScreen({super.key});

  @override
  State<ReturnPolicyScreen> createState() => _ReturnPolicyScreenState();
}

class _ReturnPolicyScreenState extends State<ReturnPolicyScreen> {
  final CollectionReference returnPolicyRef =
  FirebaseFirestore.instance.collection('return policy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarProfileScreen(),
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Return Policy",
                        style: TextStyle(
                          color: ColorsManager.darkBlue,
                          fontSize: 19.w,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  verticalSpace(0),
                  StreamBuilder<QuerySnapshot>(
                    stream: returnPolicyRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(""),
                        );
                      }
                      final returnPolicy = snapshot.data!.docs;

                      return SizedBox(
                        height: 700,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: returnPolicy.length,
                            itemBuilder: (context, i) {
                              final oneReturnPolicy =
                              returnPolicy[i];
                              final content =
                                  oneReturnPolicy['content'] ?? '';
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    content,
                                    style: TextStyles.font15RegularLightGray
                                        .copyWith(fontSize: 13,color: const Color(0xFF041A31),),
                                  ),
                                  verticalSpace(20),
                                ],
                              );
                            }),
                      );
                    },
                  ),
                  verticalSpace(40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}