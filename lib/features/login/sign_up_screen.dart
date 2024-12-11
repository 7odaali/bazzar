import 'package:bazzar/features/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isLoading = false;

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
        child: Stack(
          children: [
            // Main content
            SingleChildScrollView(
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
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
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
                                  onPressed: isLoading
                                      ? null
                                      : () async {
                                    if (_formKey.currentState!
                                        .validate()) {
                                      setState(() => isLoading = true);
                                      try {
                                        final credential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController
                                              .text,
                                        );

                                        await credential.user!
                                            .sendEmailVerification();

                                        _showSnackBar(
                                          'Account created successfully! A verification email has been sent to ${_emailController.text}.',
                                        );

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const LoginScreen(),
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        String errorMessage;

                                        switch (e.code) {
                                          case 'weak-password':
                                            errorMessage =
                                            'The password provided is too weak.';
                                            break;
                                          case 'email-already-in-use':
                                            errorMessage =
                                            'The account already exists for that email.';
                                            break;
                                          case 'invalid-email':
                                            errorMessage =
                                            'The email address is invalid.';
                                            break;
                                          default:
                                            errorMessage =
                                            'Error: ${e.message}';
                                            break;
                                        }

                                        _showSnackBar(errorMessage);
                                      } catch (e) {
                                        _showSnackBar(
                                            'An unexpected error occurred. Please try again later.');
                                      } finally {
                                        setState(() => isLoading = false);
                                      }
                                    } else {
                                      _showSnackBar(
                                          'Please fill out all fields correctly.');
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
                                        .copyWith(
                                        color: Colors.black, fontSize: 20),
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
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginScreen(),
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
            // Loading indicator
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
