import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/spacing.dart';
import '../cart/cubit/cart_cubit.dart';
import '../stores/cubit/favorite_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> productDetails;

  const ProductDetailsScreen({super.key, required this.productDetails});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _loadQuantity();
  }

  Future<void> _loadQuantity() async {
    final cartItems = context.read<CartCubit>().state;
    _quantity = cartItems
        .where((product) => product['name'] == widget.productDetails['name'])
        .length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productDetails;
    final List<String> secImages =
        List<String>.from(product['secimages'] ?? []);
    final isFavorite = context
        .watch<FavoritesCubit>()
        .state
        .any((item) => item['name'] == product['name']);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['name'] ?? 'Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.w),
                      child: product['image'] != null &&
                              product['image'].isNotEmpty
                          ? Image.network(
                              product['image'],
                              height: 250.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 100.h,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 100.h,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      right: 10.w,
                      child: IconButton(
                        onPressed: () {
                          context.read<FavoritesCubit>().updateFavorite({
                            'name': product['name'],
                            'price': product['price'],
                            'oldprice': product['oldprice'],
                            'image': product['image'],
                            'description': product['description'],
                            'secimages': product['secimages'],
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.green,
                          size: 30.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? 'Product Name',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Price: \$${product['price']}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (product['oldprice'] != null)
                    Text(
                      "Old Price: \$${product['oldprice']}",
                      style: TextStyle(
                        fontSize: 14.sp,
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
                  height: 150.h,
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
                              return Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50.h,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              verticalSpace(12),
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
              verticalSpace(8),
              Text(
                product['description'] ?? 'No description available',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              verticalSpace(30),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: SizedBox(
                  height: 50.h,
                  width: 1000.w,
                  child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                      context.read<CartCubit>().addToCart({
                        'name': product['name'],
                        'price': product['price'],
                        'image': product['image'],
                        'description': product['description'],
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Number in cart : $_quantity",
                                style: TextStyle(fontSize: 15.sp)),
                          ],
                        ),
                        Text("Add to Cart",
                            style: TextStyle(
                                fontSize: 18.w, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
