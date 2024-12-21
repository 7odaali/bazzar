/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';

import '../menu_screen.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({super.key});

  @override
  State<JoinUsScreen> createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  final formKey = GlobalKey<FormState>();
  String businessType = 'SHOP';

  TextEditingController businessNameController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarProfileScreen(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Join us",
                          style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontSize: 19.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                    const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum "
                      "has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a "
                      "galley of type and scrambled it to make a type specimen book.",
                      style: TextStyle(color: ColorsManager.darkBlue),
                    ),
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Business Type",
                          style: TextStyles.font22boldDarkBlue
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 155.w,
                          height: 50.h,
                          child: RadioListTile<String>(
                            title: Text(
                              "SHOP",
                              style: TextStyles.font17boldDarkBlue
                                  .copyWith(fontSize: 13.w),
                            ),
                            value: 'SHOP',
                            activeColor: const Color(0xFF041A31),
                            groupValue: businessType,
                            onChanged: (value) {
                              setState(() {
                                businessType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 225.w,
                          height: 50.h,
                          child: RadioListTile<String>(
                            title: Text(
                              "Small Business",
                              style: TextStyles.font17boldDarkBlue
                                  .copyWith(fontSize: 13.w),
                            ),
                            value: 'Small Business',
                            activeColor: const Color(0xFF041A31),
                            groupValue: businessType,
                            onChanged: (value) {
                              setState(() {
                                businessType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: businessNameController,
                      decoration: const InputDecoration(
                        labelText: 'Business Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the business name';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: contactNameController,
                      decoration: const InputDecoration(
                        labelText: 'Contact Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the contact name';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Message (Optional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                    verticalSpace(20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50.h,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          businessNameController.clear();
                          contactNameController.clear();
                          emailController.clear();
                          messageController.clear();
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                title: Center(
                                  child: Text(
                                    "Thanks",
                                    style: TextStyles.font22boldDarkBlue,
                                  ),
                                ),
                                content: SizedBox(
                                  height: 70.h,
                                  child: Center(
                                    child: Text(
                                      "Thanks for join us! We will contact you soon!",
                                      style: TextStyles.font16RegularGray
                                          .copyWith(
                                              color: const Color(0xFF464646)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.yellow,
                                          minimumSize: const Size(110, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.w),
                                          ),
                                        ),
                                        child: Text(
                                          "Ok",
                                          style: TextStyles.font22boldDarkBlue,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MenuScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      color: Colors.yellow,
                      textColor: ColorsManager.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 18.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    verticalSpace(30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';
import '../menu_screen.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({super.key});

  @override
  State<JoinUsScreen> createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  final formKey = GlobalKey<FormState>();
  String businessType = 'SHOP';

  TextEditingController businessNameController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarProfileScreen(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Join us",
                          style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontSize: 19.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                    const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum "
                          "has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a "
                          "galley of type and scrambled it to make a type specimen book.",
                      style: TextStyle(color: ColorsManager.darkBlue),
                    ),
                    verticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Business Type",
                          style: TextStyles.font22boldDarkBlue
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 155.w,
                          height: 50.h,
                          child: RadioListTile<String>(
                            title: Text(
                              "SHOP",
                              style: TextStyles.font17boldDarkBlue
                                  .copyWith(fontSize: 13.w),
                            ),
                            value: 'SHOP',
                            activeColor: const Color(0xFF041A31),
                            groupValue: businessType,
                            onChanged: (value) {
                              setState(() {
                                businessType = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 225.w,
                          height: 50.h,
                          child: RadioListTile<String>(
                            title: Text(
                              "Small Business",
                              style: TextStyles.font17boldDarkBlue
                                  .copyWith(fontSize: 13.w),
                            ),
                            value: 'Small Business',
                            activeColor: const Color(0xFF041A31),
                            groupValue: businessType,
                            onChanged: (value) {
                              setState(() {
                                businessType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: businessNameController,
                      decoration: const InputDecoration(
                        labelText: 'Business Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the business name';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: contactNameController,
                      decoration: const InputDecoration(
                        labelText: 'Contact Name*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the contact name';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email*',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20),
                    TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Message (Optional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                    verticalSpace(20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50.h,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          sendFormData();
                        }
                      },
                      color: Colors.yellow,
                      textColor: ColorsManager.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 18.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    verticalSpace(30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendFormData() async {
    try {
      await _firestore.collection('join_us').add({
        'businessName': businessNameController.text,
        'contactName': contactNameController.text,
        'email': emailController.text,
        'message': messageController.text,
        'businessType': businessType,
        'timestamp': FieldValue.serverTimestamp(),
      });

      businessNameController.clear();
      contactNameController.clear();
      emailController.clear();
      messageController.clear();

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: Center(
              child: Text(
                "Thanks",
                style: TextStyles.font22boldDarkBlue,
              ),
            ),
            content: SizedBox(
              height: 70.h,
              child: Center(
                child: Text(
                  "Thanks for joining us! We will contact you soon!",
                  style: TextStyles.font16RegularGray.copyWith(
                    color: const Color(0xFF464646),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      minimumSize: const Size(110, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                    ),
                    child: Text(
                      "Ok",
                      style: TextStyles.font22boldDarkBlue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MenuScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error sending data to Firestore: $e");
    }
  }
}
