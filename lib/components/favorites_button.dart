import 'package:appstore/screens/favorites_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

class FavoritesButton extends StatelessWidget {
  const FavoritesButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritesScreen(),
          ),
        );
      },
      icon: Icon(Icons.favorite_outline),
      label: FutureBuilder(
        future: getFavorites(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.length.toString());
          } else {
            return Text('0');
          }
        },
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
  }
}
