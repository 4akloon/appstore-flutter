import 'package:appstore/components/title_text.dart';
import 'package:appstore/models/product.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key key, @required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: defaultSize * 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultSize),
                    child: Hero(
                      tag: product.image,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/Spinner.gif',
                        image: SERVER_URL + product.image,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(defaultSize),
                      child: Hero(
                        tag: product.url + product.state,
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: 4, top: 4, left: 8, right: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(defaultSize * 1.6),
                              color: Colors.redAccent),
                          child: Text(
                            product.state,
                            style: TextStyle(
                              fontSize: defaultSize * 2.4,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultSize * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: product.url + product.title,
                    child: Text(
                      product.title,
                      style: theme.textTheme.headline4,
                    ),
                  ),
                  Hero(
                    tag: product.url + product.price.toString(),
                    child: Text(
                      '${product.price} грн',
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: defaultSize,
                  ),
                  Text(
                    product.description,
                    style: theme.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize),
                child: FloatingActionButton.extended(
                  heroTag: null,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text(
                    'Добавить в корзину',
                    style: theme.textTheme.headline6,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultSize),
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
                onPressed: () {},
                child: Icon(Icons.favorite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
