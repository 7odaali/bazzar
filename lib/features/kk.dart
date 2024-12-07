import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          // Get the list of documents from Firestore
          final products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              // Get each product data
              final product = products[index].data() as Map<String, dynamic>;
              final name = product['name'] ?? 'Unnamed';
              final price = product['price'] ?? '0';
              final image = product['image'] ??
                  'https://via.placeholder.com/150'; // Fallback image

              return Card(
                margin: const EdgeInsets.all(33),
                child: ListTile(
                  leading: Image.network(
                    image,
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  title: Text(name, style: const TextStyle(fontSize: 18)),
                  subtitle: Text('\$${price}', style: const TextStyle(fontSize: 16)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
