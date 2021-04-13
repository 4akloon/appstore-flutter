import 'package:appstore/components/categories.dart';
import 'package:appstore/components/favorites_button.dart';
import 'package:appstore/components/products_widget.dart';
import 'package:appstore/components/title_text.dart';
import 'package:appstore/services/api_data.dart';
import 'package:appstore/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: AppBar(
        title: Text('AppStore'),
        actions: [
          FavoritesButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(defaultSize * 2),
                child: TitleText(
                  title: 'Искать по категориям',
                ),
              ),
              FutureBuilder(
                future: getCategories(),
                builder: (context, snapshot) => snapshot.hasData
                    ? Categories(
                        categories: snapshot.data,
                      )
                    : Center(child: CircularProgressIndicator()),
              ),
              Divider(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(defaultSize * 2),
                child: TitleText(
                  title: 'Последние товары',
                ),
              ),
              FutureBuilder(
                future: getAllProducts(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ProductsWidget(products: snapshot.data)
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
