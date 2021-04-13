import 'package:flutter/material.dart';

class OrdersButton extends StatelessWidget {
  const OrdersButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(Icons.shopping_bag),
      label: Text('0'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
  }
}
