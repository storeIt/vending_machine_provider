import 'package:json_annotation/json_annotation.dart';

import '../../../constant/db_constant.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final double price;
  final String? image;
  final String category;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map[DbConstant.columnId],
      name: map[DbConstant.columnName],
      price: map[DbConstant.columnPrice],
      image: map[DbConstant.columnImageUrl],
      category: map[DbConstant.columnCategory],
      quantity: map[DbConstant.columnQuantity],
    );
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DbConstant.columnId: id,
      DbConstant.columnName: name,
      DbConstant.columnPrice: price,
      DbConstant.columnImageUrl: image,
      DbConstant.columnCategory: category,
      DbConstant.columnQuantity: quantity,
    };
    return map;
  }

  @override
  String toString() =>
      'Product{id: $id, name: $name, price: $price, image: $image, category: $category, quantity: $quantity}';
}
