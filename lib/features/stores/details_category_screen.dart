import 'package:bazzar/features/stores/category_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Favorite_screen.dart';

class DetailsCategoryScreen extends StatefulWidget {
  final String categoryId;

  const DetailsCategoryScreen({super.key, required this.categoryId});

  @override
  State<DetailsCategoryScreen> createState() => _DetailsCategoryScreenState();
}

class _DetailsCategoryScreenState extends State<DetailsCategoryScreen> {
  late CollectionReference detailsRef;
  late Future<String> categoryNameFuture;

  @override
  void initState() {
    super.initState();
    detailsRef = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('detailscategory');

    categoryNameFuture = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .get()
        .then((doc) {
      return doc['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
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
        centerTitle: true,
        title: FutureBuilder<String>(
          future: categoryNameFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("loading...");
            }

            if (snapshot.hasError) {
              return const Text("Error fetching category name");
            }

            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }

            return const Text('Category Details');
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: detailsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No detailsCategories available"));
          }

          final detailsCategories = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: detailsCategories.length,
            itemBuilder: (context, index) {
              final detailsCategory = detailsCategories[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProducts(
                        categoryId: widget.categoryId,
                        detailsCategoryId: detailsCategory.id,
                      ),
                    ),
                  );
                },


                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.w),
                          child: Image.network(
                            detailsCategory['image'],
                            fit: BoxFit.cover,
                            height: 200.h,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            detailsCategory['name'],
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
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
