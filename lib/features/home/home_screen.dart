import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../cart/cart_screen.dart';
import '../cart/cubit/cart_cubit.dart';
import '../search/filter_search_screen.dart';
import '../stores/cubit/favorite_cubit.dart';
import '../stores/Favorite_screen.dart';
import '../stores/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Query productsQuery =
      FirebaseFirestore.instance.collectionGroup('products');

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  double? _minPrice;
  double? _maxPrice;
  List<String> _selectedCategories = [];

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
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCartFromLocal();
  }

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
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        size: 30.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: Image.asset(
                        "assets/Logo.png",
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
                    ),
                  ],
                ),
              ),
            ),
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
                    width: 300.w,
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
                        hintStyle: TextStyle(fontSize: 14.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(22),
            SizedBox(
              height: 900.h,
              child: StreamBuilder<QuerySnapshot>(
                stream: productsQuery.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }

                  var products = snapshot.data!.docs.where((product) {
                    final name = (product['name'] as String).toLowerCase();
                    final data = product.data() as Map<String, dynamic>;
                    final category = data.containsKey('category')
                        ? data['category'] as String
                        : '';
                    final price = num.tryParse(data['price'].toString()) ?? 0;

                    final matchesSearch = name.contains(_searchText);
                    final matchesCategory = _selectedCategories.isEmpty ||
                        _selectedCategories.contains(category);
                    final matchesPrice =
                        (_minPrice == null || price >= _minPrice!) &&
                            (_maxPrice == null || price <= _maxPrice!);

                    return matchesSearch && matchesCategory && matchesPrice;
                  }).toList();

                  if (products.isEmpty) {
                    return const Center(
                        child: Text("No products match the filter"));
                  }

                  final favorites = context.watch<FavoritesCubit>().state;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1,
                    ),
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
                        child: Card(
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
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        child: product['image'] != null &&
                                                product['image'].isNotEmpty
                                            ? Image.network(
                                                product['image'],
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      color: Colors.grey,
                                                      size: 50.h,
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
                                            'oldprice': product['oldprice'],
                                            'image': product['image'],
                                            'description':
                                                product['description'],
                                            'secimages': product['secimages'],
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
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            verticalSpace(100),
          ],
        ),
      ),
    );
  }
}
