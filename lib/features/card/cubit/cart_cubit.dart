import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../../product_model.dart';

class CartCubit extends Cubit<List<Map<String, dynamic>>> {
  CartCubit() : super([]) {
    _loadCart();
  }

  final Box<ProductModel> _cartBox = Hive.box<ProductModel>('cartBox');

  Future<void> _loadCart() async {
    final List<Map<String, dynamic>> loadedCard =
        _cartBox.values.map((product) => product.toJson()).toList();
    emit(loadedCard);
  }

  void addToCart(Map<String, dynamic> product) async {
    final addToCart = List<Map<String, dynamic>>.from(state);

    addToCart.add(product);

    final productModel = ProductModel.fromJson(product);
    await _cartBox.put(product['name'], productModel);

    emit(addToCart);
  }

  void removeProduct(Map<String, dynamic> product) async {
    final updatedCart = List<Map<String, dynamic>>.from(state);

    final productIndex =
        updatedCart.indexWhere((item) => item['name'] == product['name']);

    if (productIndex != -1) {
      int quantity = updatedCart[productIndex]['quantity'] ?? 1;

      if (quantity > 1) {
        updatedCart[productIndex]['quantity'] = quantity - 1;

        final productModel = ProductModel.fromJson(updatedCart[productIndex]);
        await _cartBox.put(product['name'], productModel);
      } else {
        updatedCart.removeAt(productIndex);
        await _cartBox.delete(product['name']);
      }

      emit(updatedCart);
    }
  }
}
