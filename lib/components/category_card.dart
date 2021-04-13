import 'package:appstore/components/title_text.dart';
import 'package:appstore/models/category.dart';
import 'package:appstore/screens/category_detail_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(category: category),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(defaultSize * 2),
        child: SizedBox(
          width: defaultSize * 18,
          child: AspectRatio(
            aspectRatio: 0.83,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultSize),
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/Spinner.gif',
                          image: SERVER_URL + category.icon),
                    ),
                    TitleText(
                      title: category.name,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
