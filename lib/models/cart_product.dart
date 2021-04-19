import 'package:appstore/models/product.dart';

class CartProduct {
  final Product product;
  final int count;
  final int parentId;
  final int id;

  CartProduct({
    this.product,
    this.count,
    this.parentId,
    this.id,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'],
      count: json['count'],
      parentId: json['parent'],
      product: Product.fromJson(json['product']),
    );
  }
}
