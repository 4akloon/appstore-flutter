import 'package:appstore/components/products_widget.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранное'),
      ),
      body: FutureBuilder(
        future: getFavorites(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ProductsWidget(products: snapshot.data)
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
