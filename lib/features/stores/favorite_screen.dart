import 'package:bazzar/features/stores/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubit/favorite_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorite Products"),
      ),
      body: BlocBuilder<FavoritesCubit, List<Map<String, dynamic>>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return const Center(child: Text("No favorite products"));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return Card(
                child: ListTile(
                  /*onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(),
                      ),
                    );
                  },*/
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: SizedBox(
                      height: 100.h,
                      child: Image.network(
                        product['image'],
                        fit: BoxFit.cover,
                        width: 70.w,
                        height: 80.h,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                    ),
                  ),
                  title: Text(product['name']),
                  subtitle: Text("\$${product['price']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<FavoritesCubit>().removeProduct(product);
                    },
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
