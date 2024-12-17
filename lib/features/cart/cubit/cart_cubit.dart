/*
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<List<Map<String, dynamic>>> {
  CartCubit() : super([]);

  Future<void> addToCart(Map<String, dynamic> product) async {
    final cartItems = List<Map<String, dynamic>>.from(state);
    cartItems.add(product);
    emit(cartItems);
    await saveCartToLocal(cartItems);
  }

  Future<void> removeProduct(Map<String, dynamic> product) async {
    final cartItems = List<Map<String, dynamic>>.from(state);
    cartItems.remove(product);
    emit(cartItems);
    await saveCartToLocal(cartItems);
  }

  Future<void> saveCartToLocal(List<Map<String, dynamic>> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', jsonEncode(cartItems));
  }

  Future<void> loadCartFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final cartItems = List<Map<String, dynamic>>.from(
          jsonDecode(cartData).map((item) => item as Map<String, dynamic>));
      emit(cartItems);
    }
  }

  Future<void> createOrder() async {
    if (state.isEmpty) return;

    final orderData = {
      'items': state,
      'total_price': state.fold<double>(
          0.0,
          (sum, item) =>
              sum + (double.tryParse(item['price'].toString()) ?? 0.0)),
      'created_at': FieldValue.serverTimestamp(),
    };

    try {
      final docRef =
          await FirebaseFirestore.instance.collection('orders').add(orderData);
      await docRef.update({'order_id': docRef.id});

      emit([]);
      await saveCartToLocal([]);
    } catch (e) {
      print("Error saving order: $e");
    }
  }
}
*/
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<List<Map<String, dynamic>>> {
  CartCubit() : super([]);

  Future<void> addToCart(Map<String, dynamic> product) async {
    final cartItems = List<Map<String, dynamic>>.from(state);
    cartItems.add(product);
    emit(cartItems);
    await saveCartToLocal(cartItems);
  }

  Future<void> removeProduct(Map<String, dynamic> product) async {
    final cartItems = List<Map<String, dynamic>>.from(state);
    cartItems.remove(product);
    emit(cartItems);
    await saveCartToLocal(cartItems);
  }

  Future<void> saveCartToLocal(List<Map<String, dynamic>> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', jsonEncode(cartItems));
  }

  Future<void> loadCartFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final cartItems = List<Map<String, dynamic>>.from(
          jsonDecode(cartData).map((item) => item as Map<String, dynamic>));
      emit(cartItems);
    }
  }

  Future<void> createOrder() async {
    if (state.isEmpty) return;

    final orderData = {
      'items': state,
      'total_price': state.fold<double>(
          0.0,
              (sum, item) =>
          sum + (double.tryParse(item['price'].toString()) ?? 0.0)),
      'created_at': FieldValue.serverTimestamp(),
    };

    try {
      final docRef =
      await FirebaseFirestore.instance.collection('orders').add(orderData);
      await docRef.update({'order_id': docRef.id});

      emit([]);
      await saveCartToLocal([]);
    } catch (e) {
      print("Error saving order: $e");
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
      print("Order deleted successfully: $orderId");
    } catch (e) {
      print("Error deleting order: $e");
    }
  }
}
