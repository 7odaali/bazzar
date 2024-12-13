import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<Map<String, dynamic>>> {
  FavoritesCubit() : super([]);

  void addProduct(Map<String, dynamic> product) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);
    updatedFavorites.add(product);
    emit(updatedFavorites);
  }

  void removeProduct(Map<String, dynamic> product) {
    final updatedFavorites = List<Map<String, dynamic>>.from(state);
    updatedFavorites.remove(product);
    emit(updatedFavorites);
  }
}
