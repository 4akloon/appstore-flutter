import 'package:appstore/models/cart_product.dart';
import 'package:appstore/screens/product_detail_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getCartProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center();
          }
          if (snapshot.hasData) {
            List<CartProduct> cartProductsList = snapshot.data;
            return ListView.builder(
              itemCount: cartProductsList.length,
              itemBuilder: (BuildContext context, int index) {
                int count = cartProductsList[index].count;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: cartProductsList[index].product,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultSize * 1.6),
                    ),
                    margin: EdgeInsets.all(defaultSize * 0.8),
                    elevation: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(defaultSize * 1.2),
                          child: Container(
                            width: defaultSize * 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(defaultSize * 1.2),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  FadeInImage.assetNetwork(
                                    placeholder: 'assets/Spinner.gif',
                                    image: SERVER_URL +
                                        cartProductsList[index].product.image,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: 4, top: 4, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            defaultSize * 1.6),
                                        color: Colors.redAccent),
                                    child: Text(
                                      cartProductsList[index].product.state,
                                      style: TextStyle(
                                        fontSize: defaultSize * 1.6,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(defaultSize * 1.2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartProductsList[index].product.title,
                                  style: Theme.of(context).textTheme.title,
                                ),
                                Text(
                                  cartProductsList[index]
                                          .product
                                          .price
                                          .toString() +
                                      ' грн',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: defaultSize * 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            if (count > 1) {
                                              count -= 1;
                                              await changeCartProductCount(
                                                  count,
                                                  cartProductsList[index].id);
                                              setState(() {});
                                            }
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                        Text(cartProductsList[index]
                                            .count
                                            .toString()),
                                        IconButton(
                                          onPressed: () async {
                                            if (count < 10) {
                                              count += 1;
                                              await changeCartProductCount(
                                                  count,
                                                  cartProductsList[index].id);
                                              setState(() {});
                                            }
                                          },
                                          icon: Icon(Icons.add),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                          await deleteCartProduct(
                                              cartProductsList[index].id);
                                          setState(() {});
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
