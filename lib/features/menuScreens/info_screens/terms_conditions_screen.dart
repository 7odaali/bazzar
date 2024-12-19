import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../myaccount/widget/app_bar_profile_screen.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final CollectionReference termsAndConditionsRef =
      FirebaseFirestore.instance.collection('terms and conditions');

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
                        "Terms & Conditions",
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
                    stream: termsAndConditionsRef.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(""),
                        );
                      }
                      final termsAndConditions = snapshot.data!.docs;

                      return SizedBox(
                        height: 700,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: termsAndConditions.length,
                            itemBuilder: (context, i) {
                              final oneTermsAndCondition =
                                  termsAndConditions[i];
                              final content =
                                  oneTermsAndCondition['content'] ?? '';
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    content,
                                    style: TextStyles.font15RegularLightGray
                                        .copyWith(fontSize: 13),
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
