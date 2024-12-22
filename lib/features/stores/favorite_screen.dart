import 'package:bazzar/features/stores/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theming/styles.dart';
import 'cubit/favorite_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Wishlist"),
      ),
      body: BlocBuilder<FavoritesCubit, List<Map<String, dynamic>>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Favorite added yet",
                  style: TextStyles.font22boldDarkBlue.copyWith(fontSize: 19),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.yellow,
                  size: 45.w,
                )
              ],
            ));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.95,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];

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
                        padding:  EdgeInsets.all(8.0.w),
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return  Icon(
                                            Icons.broken_image,
                                            size: 50.w,
                                            color: Colors.grey,
                                          );
                                        },
                                      )
                                    :  Icon(
                                        Icons.image_not_supported,
                                        size: 50.w,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.favorite,
                                    color: Colors.red),
                                onPressed: () {
                                  context
                                      .read<FavoritesCubit>()
                                      .removeProduct(product);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              product['name'],
                              style: TextStyle(
                                fontSize: 15.w,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\$${product['price']}",
                              style: TextStyle(
                                fontSize: 13.w,
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
          );
        },
      ),
    );
  }
}
