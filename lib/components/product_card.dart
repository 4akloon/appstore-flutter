import 'package:appstore/components/title_text.dart';
import 'package:appstore/models/product.dart';
import 'package:appstore/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(defaultSize * 0.4),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultSize * 1.6),
          ),
          child: AspectRatio(
            aspectRatio: 0.693,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultSize),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(defaultSize * 1.6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(defaultSize * 0.6),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/Spinner.gif',
                              image: SERVER_URL + product.image,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: 4, top: 4, left: 8, right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        defaultSize * 1.6),
                                    color: Colors.redAccent),
                                child: Text(
                                  product.state,
                                  style: TextStyle(
                                    fontSize: defaultSize * 1.6,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: defaultSize * 0.8, right: defaultSize * 0.8),
                  child: Text(
                    product.title,
                    style: theme.textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultSize * 0.5),
                  child: Text(
                    '${product.price.toString()} грн',
                    style: theme.textTheme.subtitle2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
