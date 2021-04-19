import 'package:appstore/components/product_images_widget.dart';
import 'package:appstore/models/product.dart';
import 'package:appstore/models/review.dart';
import 'package:appstore/screens/cart_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key key, @required this.product})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: body(defaultSize, theme),
      bottomNavigationBar: bottomAppBar(defaultSize, context, theme),
    );
  }

  SingleChildScrollView body(double defaultSize, ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    tag: widget.product.image,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/Spinner.gif',
                      image: SERVER_URL + widget.product.image,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(defaultSize),
                    child: Hero(
                      tag: widget.product.url + widget.product.state,
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: 4, top: 4, left: 8, right: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(defaultSize * 1.6),
                            color: Colors.redAccent),
                        child: Text(
                          widget.product.state,
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
                  tag: widget.product.url + widget.product.title,
                  child: Text(
                    widget.product.title,
                    style: theme.textTheme.headline4,
                  ),
                ),
                Hero(
                  tag: widget.product.url + widget.product.price.toString(),
                  child: Text(
                    '${widget.product.price} грн',
                    style: theme.textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: defaultSize,
                ),
                Text(
                  widget.product.description,
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
          ProductImagesWidget(product: widget.product),
          buildReviews()
        ],
      ),
    );
  }

  Widget buildReviews() {
    double defaultSize = SizeConfig.defaultSize;
    var theme = Theme.of(context);
    return FutureBuilder(
      future: getProductReviews(widget.product.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
                  Card(
                    child: ListTile(
                      title: Text('Відгуки (${snapshot.data.length})'),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultSize,
                        vertical: defaultSize * 0.6,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.message),
                                labelText: 'Введіть відгук',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                          ),
                          IconButton(icon: Icon(Icons.send), onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ] +
                List.generate(
                  snapshot.data.length,
                  (index) {
                    Review review = snapshot.data[index];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              size: defaultSize * 5,
                            ),
                            title: Text(review.customer.user.first_name +
                                ' ' +
                                review.customer.user.last_name),
                            subtitle: Text(review.date.toString()),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              review.text,
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                  future: getReplyReviews(review.id),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.length > 0) {
                                        return TextButton.icon(
                                          onPressed: () {
                                            // Perform some action
                                          },
                                          icon: Icon(Icons.reply),
                                          label: Text(
                                              'Дивитися відповіді (${snapshot.data.length.toString()})'),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    } else {
                                      return Container();
                                    }
                                  }),
                              TextButton.icon(
                                onPressed: () {
                                  // Perform some action
                                },
                                icon: Icon(Icons.reply),
                                label: Text('Відповісти'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  BottomAppBar bottomAppBar(
      double defaultSize, BuildContext context, ThemeData theme) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(defaultSize),
              child: FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                onPressed: () async {
                  await addCartProduct(widget.product.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
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
            child: FutureBuilder(
              future: checkLike(widget.product.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 202) {
                    return FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        await setLike(widget.product.id);
                        setState(() {});
                      },
                      child: Icon(Icons.favorite_border),
                    );
                  } else {
                    return FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        await deleteLike(widget.product.id);
                        setState(() {});
                      },
                      child: Icon(Icons.favorite),
                    );
                  }
                } else {
                  return FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                    onPressed: () async {
                      await setLike(widget.product.id);
                      setState(() {});
                    },
                    child: Icon(Icons.favorite_border),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
