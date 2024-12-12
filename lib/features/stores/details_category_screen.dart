import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsCategoryScreen extends StatefulWidget {
  final String categoryId;

  const DetailsCategoryScreen({super.key, required this.categoryId});

  @override
  State<DetailsCategoryScreen> createState() => _DetailsCategoryScreenState();
}

class _DetailsCategoryScreenState extends State<DetailsCategoryScreen> {
  late CollectionReference detailsRef;

  @override
  void initState() {
    super.initState();
    detailsRef = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .collection('detailscategory');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: detailsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(borderRadius: BorderRadius.circular(10.w),
                        child: Image.network(
                          product['image'],
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
                          product['name'],
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
