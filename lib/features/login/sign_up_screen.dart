import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.h,
              width: 10000000000.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: ColorsManager.darkBlue,
              ),
              child: Image.asset("assets/Logo.png"),
            ),
            verticalSpace(22),
            Padding(
              padding: EdgeInsets.all(14.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Create an account",
                          style: TextStyles.font22boldDarkBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Create new account",
                          style: TextStyles.font15boldDarkBlue),
                    ],
                  ),
                  verticalSpace(30),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(30),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(30),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        SizedBox(
                          width: 400.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                            ),
                            child: Text(
                              "Register",
                              style: TextStyles.font22boldDarkBlue
                                  .copyWith(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        verticalSpace(50),
                        Text("Already have an account?",style: TextStyles.font15boldDarkBlue,),
                        verticalSpace(20),
                        SizedBox(
                          width: 400.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyles.font17boldYellow,
                            ),
                          ),
                        ),
                      ],
        
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}