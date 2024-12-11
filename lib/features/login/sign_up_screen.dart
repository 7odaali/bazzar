import 'package:bazzar/features/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../home_screen.dart';

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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250.h,
                width: double.infinity,
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
                    Text(
                      "Create an account",
                      style: TextStyles.font22boldDarkBlue,
                    ),
                    verticalSpace(8),
                    Text(
                      "Create new account",
                      style: TextStyles.font15boldDarkBlue,
                    ),
                    verticalSpace(30),
                    Form(
                      key: _formKey,
                      child: Column(
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
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email address';
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
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(20),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    final credential = await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeScreen(),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      _showSnackBar('The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                      _showSnackBar(
                                          'The account already exists for that email.');
                                    } else {
                                      _showSnackBar('Error: ${e.message}');
                                    }
                                  } catch (e) {
                                    _showSnackBar('Error: $e');
                                  }
                                }
                              },
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
                          Text(
                            "Already have an account?",
                            style: TextStyles.font15boldDarkBlue,
                          ),
                          verticalSpace(20),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
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
      ),
    );
  }
}
