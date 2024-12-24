import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final CollectionReference questionAndAnswerRef =
      FirebaseFirestore.instance.collection('question and answer');

  List<bool> _expandedStates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          const AppBarProfileScreen(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              children: [
                verticalSpace(20),
                Row(
                  children: [
                    Text(
                      "FAQ's",
                      style: TextStyle(
                        color: ColorsManager.darkBlue,
                        fontSize: 19.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: questionAndAnswerRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No FAQs available"),
                      );
                    }

                    final questionsAndAnswers = snapshot.data!.docs;

                    if (_expandedStates.length != questionsAndAnswers.length) {
                      _expandedStates =
                          List<bool>.filled(questionsAndAnswers.length, false);
                    }

                    return SizedBox(
                      height: 560,
                      child: ListView.builder(
                        itemCount: questionsAndAnswers.length,
                        itemBuilder: (context, i) {
                          final questionAndAnswer = questionsAndAnswers[i];
                          final question = questionAndAnswer['question'] ?? '';
                          final answer = questionAndAnswer['answer'] ?? '';

                          return Column(
                            children: [
                              Card(
                                color: Colors.white,
                                elevation: 0,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        question,
                                        style: TextStyles.font15RegularLightGray
                                            .copyWith(
                                          fontSize: 13.w,
                                          color: const Color(0xFF041A31),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          _expandedStates[i]
                                              ? Icons.remove
                                              : Icons.add,
                                          size: 30.w,
                                          color: Colors.yellow,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _expandedStates[i] =
                                                 !_expandedStates[i];
                                          });
                                        },
                                      ),
                                    ),
                                    if (_expandedStates[i])
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        child: Text(
                                          answer,
                                          style: TextStyle(
                                            fontSize: 12.w,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              verticalSpace(10)
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                verticalSpace(40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
