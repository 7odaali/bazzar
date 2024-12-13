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
