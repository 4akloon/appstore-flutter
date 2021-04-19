import 'package:appstore/constants.dart';
import 'package:appstore/models/product.dart';
import 'package:appstore/models/product_image.dart';
import 'package:appstore/screens/image_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:appstore/size_config.dart';
import 'package:flutter/material.dart';

class ProductImagesWidget extends StatelessWidget {
  const ProductImagesWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return FutureBuilder(
      future: getProductImages(product.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length != 0) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(defaultSize),
                child: Row(
                  children: List.generate(
                    snapshot.data.length,
                    (index) => ImageWidget(image: snapshot.data[index]),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key key,
    @required this.image,
  }) : super(key: key);

  final ProductImage image;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageScreen(
                      imageUrl: SERVER_URL + image.imageUrl,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.all(defaultSize * 0.2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(defaultSize),
          ),
          child: Padding(
            padding: EdgeInsets.all(defaultSize * 0.6),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/Spinner.gif',
              image: SERVER_URL + image.imageUrl,
              height: defaultSize * 18,
            ),
          ),
        ),
      ),
    );
  }
}
