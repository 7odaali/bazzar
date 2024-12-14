/*
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String price;

  @HiveField(3)
  String oldPrice;

  @HiveField(4)
  String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
  });
}
*/
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? price;

  @HiveField(3)
  String? oldprice;

  @HiveField(4)
  String? image;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.oldprice,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      oldprice: json['oldprice'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'oldprice': oldprice,
      'image': image,
    };
  }
}
