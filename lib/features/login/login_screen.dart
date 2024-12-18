import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/login/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/custom_bottom_navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
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
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
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
                              onPressed: () async {
                                if (_emailController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "add your email...",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: _emailController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "تم ارسال لينك لاعادة تعبن كلمة المرور",
                                      ),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                } catch (e) {
                                  print("e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "add correct email...",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
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
                              if (_formKey.currentState?.validate() ?? false) {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );

                                  User? user = credential.user;

                                  if (user != null) {
                                    final userRef = FirebaseFirestore.instance
                                        .collection('users');

                                    final userSnapshot =
                                        await userRef.doc(user.uid).get();
                                    if (!userSnapshot.exists) {
                                      await userRef.doc(user.uid).set({
                                        'email': user.email,
                                        'uid': user.uid,
                                        'createdAt':
                                            FieldValue.serverTimestamp(),
                                      });
                                    }
                                  }

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigationBarScreen()),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Welcome....."),
                                        backgroundColor: Colors.green),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  String errorMessage;

                                  switch (e.code) {
                                    case 'user-not-found':
                                      errorMessage =
                                          'No user found for that email.';
                                      break;
                                    case 'wrong-password':
                                      errorMessage =
                                          'Wrong password provided for that user.';
                                      break;
                                    case 'invalid-email':
                                      errorMessage =
                                          'The email address is not valid.';
                                      break;
                                    case 'user-disabled':
                                      errorMessage =
                                          'This user account has been disabled.';
                                      break;
                                    case 'too-many-requests':
                                      errorMessage =
                                          'Too many requests. Please try again later.';
                                      break;
                                    default:
                                      errorMessage =
                                          'An unexpected error occurred. Please try again.';
                                      break;
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(errorMessage),
                                        backgroundColor: Colors.red),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'An error occurred. Please try again later.'),
                                        backgroundColor: Colors.red),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please fill out all fields correctly.'),
                                      backgroundColor: Colors.orange),
                                );
                              }
                            },
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
