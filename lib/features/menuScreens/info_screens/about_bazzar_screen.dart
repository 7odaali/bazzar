import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';

class AboutBazzarScreen extends StatefulWidget {
  const AboutBazzarScreen({super.key});

  @override
  State<AboutBazzarScreen> createState() => _AboutBazzarScreenState();
}

class _AboutBazzarScreenState extends State<AboutBazzarScreen> {
  final CollectionReference aboutbazzarRef =
      FirebaseFirestore.instance.collection('aboutbazzar');

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
                        "About Bazzar",
                        style: TextStyle(
                          color: ColorsManager.darkBlue,
                          fontSize: 19.w,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  verticalSpace(20),
                  Center(
                    child: Image.asset(
                      "assets/LOGO1.png",
                      height: 100.h,
                    ),
                  ),
                  verticalSpace(20),
                  StreamBuilder<QuerySnapshot>(
                      stream: aboutbazzarRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(""),
                          );
                        }
                        final aboutBazzar = snapshot.data!.docs;

                        return SizedBox(
                          height: 700,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: aboutBazzar.length,
                              itemBuilder: (context, i) {
                                final oneAboutBazzar = aboutBazzar[i];
                                final content = oneAboutBazzar['content'] ?? '';
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      content,
                                      style: TextStyles.font15RegularLightGray
                                          .copyWith(
                                        fontSize: 13,
                                        color: const Color(0xFF041A31),
                                      ),
                                    ),
                                    verticalSpace(20),
                                  ],
                                );
                              }),
                        );
                      }),
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
