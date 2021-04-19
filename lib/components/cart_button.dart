import 'package:appstore/screens/cart_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key key,
    this.color = null,
  }) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartScreen(),
          ),
        );
      },
      icon: Icon(Icons.shopping_cart_outlined),
      label: FutureBuilder(
        future: getCartProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.length.toString());
          } else {
            return Text('0');
          }
        },
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          color != null ? color : Theme.of(context).textTheme.title.color,
        ),
      ),
    );
  }
}
