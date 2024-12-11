import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/login/sign_up_screen.dart';
import 'package:bazzar/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /* void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      print("Username: $username, Password: $password");
    }
  }*/

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
                      Text("Login", style: TextStyles.font22boldDarkBlue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Login into your Account!",
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
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text("Forgot Password?",
                                  style: TextStyles.font15boldDarkBlue
                                      .copyWith(color: Colors.black)),
                            ),
                          ],
                        ),
                        verticalSpace(20),
                        SizedBox(
                          width: 400.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            } /*_submitForm*/,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyles.font22boldDarkBlue
                                  .copyWith(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        /*  Text(
                          "Login through Social media",
                          style: TextStyles.font15boldDarkBlue
                              .copyWith(color: Colors.black),
                        ),
                        verticalSpace(20),
                        Row(
                          children: [
                            Image.asset("assets/White-Logo-Square-.png"),
                            Image.asset("assets/Google.png"),
                            Image.asset("assets/facebook.png"),
                          ],
                        ),
                        verticalSpace(20),*/
                        Text(
                          "Don’t have an account?",
                          style: TextStyles.font15boldDarkBlue
                              .copyWith(color: Colors.black),
                        ),
                        verticalSpace(20),
                        SizedBox(
                          width: 400.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                            ),
                            child: Text("Create An Account",
                                style: TextStyles.font17boldYellow),
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
