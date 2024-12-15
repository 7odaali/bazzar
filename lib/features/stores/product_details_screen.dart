import 'package:bazzar/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> productDetails;

  const ProductDetailsScreen({
    super.key,
    required this.productDetails,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.productDetails;
    final List<String> secImages =
        List<String>.from(product['secimages'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'] ?? 'Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.w),
                  child: Image.network(
                    product['image'] ?? '',
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.broken_image,
                        size: 100.h,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                product['name'] ?? 'Product Name',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Price : \$${product['price']}",
                    style: TextStyle(
                      fontSize: 14.w,
                    ),
                  ),
                  Text(
                    "Oldprice : \$${product['oldprice']}",
                    style: TextStyle(
                      fontSize: 14.w,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              verticalSpace(12),
              if (secImages.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Additional Images",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                verticalSpace(8),
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: secImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.0.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.w),
                          child: Image.network(
                            secImages[index],
                            width: 150.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.broken_image,
                                size: 100.h,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],                verticalSpace(12),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(5),
                  Text(
                    product['description'] ?? '..',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              verticalSpace(16),

            ],
          ),
        ),
      ),
    );
  }
}
