import 'package:bazzar/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../myaccount/my_address_screen.dart';
import '../stores/product_details_screen.dart';
import 'cubit/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("My Cart"),
            SizedBox(
              width: 20.w,
            ),
            const Icon(Icons.shopping_cart),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 50.w,
                ),
                const Text(
                  "No items in the cart...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<CartCubit, List<Map<String, dynamic>>>(
                  builder: (context, cartItems) {
                    double totalPrice = 0.0;
                    for (var product in cartItems) {
                      totalPrice +=
                          double.tryParse(product['price'].toString()) ?? 0.0;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
                        Text(
                          "Total price : \$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ColorsManager.darkBlue),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 610.h,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                productDetails: {
                                  'name': product['name'],
                                  'price': product['price'],
                                  'oldprice': product['oldprice'],
                                  'image': product['image'],
                                  'description': product['description'],
                                  'secimages': product['secimages'],
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.w),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.w),
                                      child: SizedBox(
                                        height: 130.h,
                                        width: double.infinity,
                                        child: product['image'] != null &&
                                                product['image'].isNotEmpty
                                            ? Image.network(
                                                product['image'],
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                    Icons.broken_image,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  );
                                                },
                                              )
                                            : const Icon(
                                                Icons.image_not_supported,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: 40.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(.5),
                                            borderRadius:
                                                BorderRadius.circular(100.w)),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(Icons.remove,
                                                size: 25.w, color: Colors.red),
                                            onPressed: () {
                                              context
                                                  .read<CartCubit>()
                                                  .removeProduct(product);
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "\$${product['price']}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                /*    Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, ),
                  child: MaterialButton(
                    minWidth: 1000.w,
                    height: 50.h,
                    onPressed: () {
                      context.read<CartCubit>().createOrder();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order created successfully...'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    color: Colors.yellow,
                    textColor: ColorsManager.darkBlue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.w),
                    ),
                    child: Text(
                      'Create Order',
                      style: TextStyle(
                          fontSize: 19.w, fontWeight: FontWeight.bold),
                    ),
                  ),

                ),*/
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: MaterialButton(
                    minWidth: 1000.w,
                    height: 50.h,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyAddressScreen(
                            cartItems: List<Map<String, dynamic>>.from(
                                context.read<CartCubit>().state),
                          ),
                        ),
                      );
                    },
                    color: Colors.yellow,
                    textColor: ColorsManager.darkBlue,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.w),
                    ),
                    child: Text(
                      'Choose Address',
                      style: TextStyle(
                          fontSize: 19.w, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
