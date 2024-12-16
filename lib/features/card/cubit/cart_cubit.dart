import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../../product_model.dart';

class CartCubit extends Cubit<List<Map<String, dynamic>>> {
  CartCubit() : super([]) {
    _loadCart();
  }

  final Box<ProductModel> _cartBox =
  Hive.box<ProductModel>('cartBox');

  Future<void> _loadCart() async {
    final List<Map<String, dynamic>> loadedCard =
    _cartBox.values.map((product) => product.toJson()).toList();
    emit(loadedCard);
  }

  void updateCart(Map<String, dynamic> product) async {
    final updatedCart= List<Map<String, dynamic>>.from(state);

    bool productExists =
    updatedCart.any((item) => item['name'] == product['name']);

    if (productExists) {
      updatedCart.add(product);
      final productModel = ProductModel.fromJson(product);
      await _cartBox.put(product['name'], productModel);
    } else {
        updatedCart.add(product);
        final productModel = ProductModel.fromJson(product);
        await _cartBox.put(product['name'], productModel);
    }

    emit(updatedCart);
  }

  void removeProduct(Map<String, dynamic> product) async {
    final updatedCart = List<Map<String, dynamic>>.from(state);
    updatedCart.removeWhere((item) => item['name'] == product['name']);
    emit(updatedCart);
    await _cartBox.delete(product['name']);
  }
}
