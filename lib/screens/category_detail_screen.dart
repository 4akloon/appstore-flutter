import 'package:appstore/components/products_widget.dart';
import 'package:appstore/models/category.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatelessWidget {
  final Category category;

  const CategoryProductsScreen({Key key, @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: FutureBuilder(
        future: getCategoryProducts(category.url),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ProductsWidget(products: snapshot.data)
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
