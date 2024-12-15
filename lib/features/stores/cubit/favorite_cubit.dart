import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import '../../../product_model.dart';

class FavoritesCubit extends Cubit<List<Map<String, dynamic>>> {
  FavoritesCubit() : super([]) {
    _loadFavorites();
  }

  final Box<ProductModel> _favoritesBox =
      Hive.box<ProductModel>('favoritesBox');

  Future<void> _loadFavorites() async {
    final List<Map<String, dynamic>> loadedFavorites =
        _favoritesBox.values.map((product) => product.toJson()).toList();
    emit(loadedFavorites);
  }

  void updateFavorite(Map<String, dynamic> product) async {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);

    bool productExists =
        updatedFavorites.any((item) => item['name'] == product['name']);

    if (productExists) {
      updatedFavorites.removeWhere((item) => item['name'] == product['name']);
      await _favoritesBox.delete(product['name']);
    } else {
      updatedFavorites.add(product);
      final productModel = ProductModel.fromJson(product);
      await _favoritesBox.put(product['name'], productModel);
    }

    emit(updatedFavorites);
  }

  void removeProduct(Map<String, dynamic> product) async {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);
    updatedFavorites.removeWhere((item) => item['name'] == product['name']);
    emit(updatedFavorites);
    await _favoritesBox.delete(product['name']);
  }
}
