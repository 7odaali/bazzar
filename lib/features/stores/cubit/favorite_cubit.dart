/*

import 'package:bloc/bloc.dart';

class FavoritesCubit extends Cubit<List<Map<String, dynamic>>> {
  FavoritesCubit() : super([]);

  void addProduct(Map<String, dynamic> product) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);

    bool productExists =
        updatedFavorites.any((item) => item['name'] == product['name']);

    if (!productExists) {
      updatedFavorites.add(product);
      emit(updatedFavorites);
    }
  }

  void removeProduct(Map<String, dynamic> product) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);
    updatedFavorites.removeWhere((item) => item['name'] == product['name']);
    emit(updatedFavorites);
  }
}
*/
import 'package:bloc/bloc.dart';

class FavoritesCubit extends Cubit<List<Map<String, dynamic>>> {
  FavoritesCubit() : super([]);

  void updateFavorite(Map<String, dynamic> product) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);

    bool productExists =
        updatedFavorites.any((item) => item['name'] == product['name']);

    if (productExists) {
      updatedFavorites.removeWhere((item) => item['name'] == product['name']);
    } else {
      updatedFavorites.add(product);
    }

    emit(updatedFavorites);
  }

  void removeProduct(Map<String, dynamic> product) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);
    updatedFavorites.removeWhere((item) => item['name'] == product['name']);
    emit(updatedFavorites);
  }
}
