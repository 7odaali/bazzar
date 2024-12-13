import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/stores/details_category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import 'Favorite_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final CollectionReference productsRef =
  FirebaseFirestore.instance.collection('categories');

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
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SizedBox(width: 50.w,),
                  Center(
                    child: SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: Image.asset(
                        "assets/Logo.png",
                        height: 10.h,
                        width: 10.w,
                        fit: BoxFit.contain,
                      ),
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
                  ),
                ],
              ),
            ),
            verticalSpace(30),
            SizedBox(
              height: 800.h,
              child: StreamBuilder<QuerySnapshot>(
                stream: productsRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No categories available"));
                  }

                  final categories = snapshot.data!.docs;

                  return GridView.builder(
                    shrinkWrap: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, i) {
                      final category = categories[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsCategoryScreen(
                                categoryId: category.id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:180.h,
                                  width: 200.w,
                                  child: ClipRRect(borderRadius: BorderRadius.circular(10.w),
                                    child: Image.network(
                                      category['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
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
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                category['name'],
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            verticalSpace(20)
          ],
        ),
      ),
    );
  }
}
