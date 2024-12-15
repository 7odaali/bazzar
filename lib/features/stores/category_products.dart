import 'package:bazzar/features/stores/product_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../search/filter_search_screen.dart';
import 'Favorite_screen.dart';
import 'cubit/favorite_cubit.dart';

class CategoryProducts extends StatefulWidget {
  final String categoryId;
  final String detailsCategoryId;

  const CategoryProducts({
    super.key,
    required this.categoryId,
    required this.detailsCategoryId,
  });

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  late CollectionReference productsRef;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  double? _minPrice;
  double? _maxPrice;
  List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();

    productsRef = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('detailscategory')
        .doc(widget.detailsCategoryId)
        .collection('products');
  }

  void _applyFilter() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FilterSearchScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _minPrice = result['minPrice'];
        _maxPrice = result['maxPrice'];
        _selectedCategories = List<String>.from(result['categories']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
              color: Colors.black,
            ),
          ),
        ],
        title: const Text('Category Products'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _applyFilter,
                  icon: Icon(
                    Icons.filter_list,
                    size: 30.w,
                  ),
                ),
                SizedBox(
                  height: 45.h,
                  width: 320.w,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchText = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search for products...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: productsRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No products available"));
                }

                final products = snapshot.data!.docs.where((product) {
                  final name = (product['name'] as String).toLowerCase();
                  final category = product['category'] as String;
                  final price = num.tryParse(product['price'].toString()) ?? 0;
                  // Filter @mahmoud
                  final matchesSearch = name.contains(_searchText);
                  final matchesCategory = _selectedCategories.isEmpty ||
                      _selectedCategories.contains(category);
                  final matchesPrice =
                      (_minPrice == null || price >= _minPrice!) &&
                          (_maxPrice == null || price <= _maxPrice!);

                  return matchesSearch && matchesCategory && matchesPrice;
                }).toList();

                if (products.isEmpty) {
                  return const Center(child: Text("No products available"));
                }

                final favorites = context.watch<FavoritesCubit>().state;

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    bool isFavorite = favorites
                        .any((item) => item['name'] == product['name']);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              productDetails: {
                                'name': product['name'],
                                'price': product['price'],
                                'image': product['image'],
                                'oldprice': product['oldprice'],
                                'description': product['description'],
                                'secimages': product['secimages'],
                              },
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 130.h,
                                      width: 200.w,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        child: product['image'] != null &&
                                                product['image'].isNotEmpty
                                            ? Image.network(
                                                product['image'],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      size: 50.h,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              )
                                            : Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 50.h,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<FavoritesCubit>()
                                              .updateFavorite({
                                            'name': product['name'],
                                            'price': product['price'],
                                            'image': product['image'],
                                          });
                                        },
                                        icon: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.green,
                                          size: 30.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "\$${product['price']}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
