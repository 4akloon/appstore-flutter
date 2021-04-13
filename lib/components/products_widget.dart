import 'package:appstore/models/product.dart';
import 'package:appstore/size_config.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeConfig.orientation == Orientation.portrait ? 2 : 4,
        childAspectRatio: 0.693,
      ),
      itemBuilder: (context, index) => ProductCard(
        product: products[index],
      ),
    );
  }
}
