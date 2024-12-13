/*
import 'package:bazzar/features/stores/Favorite_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../login/login_screen.dart';
import '../stores/cubit/favorite_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Query productsQuery =
  FirebaseFirestore.instance.collectionGroup('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: ColorsManager.darkBlue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                      ),
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: Image.asset(
                        "assets/Logo.png",
                        height: 10.h,
                        width: 10.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        size: 30.h,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            verticalSpace(22),
            SizedBox(
              height: 800.h,
              child: StreamBuilder<QuerySnapshot>(
                stream: productsQuery.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }

                  final products = snapshot.data!.docs;
                  final favorites = context.watch<FavoritesCubit>().state;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      bool isFavorite = favorites.any((item) =>
                      item['name'] == product['name']);

                      return Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 130.h,
                                    width: 200.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.w),
                                      child: Image.network(
                                        product['image'],
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                              size: 50.h,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<FavoritesCubit>().updateFavorite({
                                          'name': product['name'],
                                          'price': product['price'],
                                          'image': product['image'],
                                        });
                                      },
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: isFavorite ? Colors.red : Colors.green,
                                        size: 30.h,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  product['name'],
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                Text(
                                  "\$${product['price']}",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:bazzar/features/stores/Favorite_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../login/login_screen.dart';
import '../stores/cubit/favorite_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Query productsQuery = FirebaseFirestore.instance.collectionGroup('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: ColorsManager.darkBlue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                      ),
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: Image.asset(
                        "assets/Logo.png",
                        height: 10.h,
                        width: 10.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        size: 30.h,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            verticalSpace(22),
            SizedBox(
              height: 800.h,
              child: StreamBuilder<QuerySnapshot>(
                stream: productsQuery.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }

                  final products = snapshot.data!.docs;
                  final favorites = context.watch<FavoritesCubit>().state;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      bool isFavorite = favorites.any((item) => item['name'] == product['name']);

                      return Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 130.h,
                                    width: 200.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.w),
                                      child: Image.network(
                                        product['image'],
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                              size: 50.h,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<FavoritesCubit>().updateFavorite({
                                          'name': product['name'],
                                          'price': product['price'],
                                          'image': product['image'],
                                        });
                                      },
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: isFavorite ? Colors.red : Colors.green,
                                        size: 30.h,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  product['name'],
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                Text(
                                  "\$${product['price']}",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
