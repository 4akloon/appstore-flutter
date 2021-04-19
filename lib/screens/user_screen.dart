import 'package:appstore/auth_config.dart';
import 'package:appstore/components/cart_button.dart';
import 'package:appstore/components/favorites_button.dart';
import 'package:appstore/components/orders_button.dart';
import 'package:appstore/models/user.dart';
import 'package:appstore/screens/login_screen.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    print(AuthConfig.isAuthorize.toString());
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return AuthConfig.isAuthorize ? buildProfile(defaultSize) : buildLogin();
  }

  Scaffold buildProfile(double defaultSize) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
        future: getMe(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            UserModel user = snapshot.data;
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: defaultSize * 2),
                      child: Icon(
                        Icons.person,
                        size: defaultSize * 12.8,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FavoritesButton(),
                          CartButton(),
                          OrdersButton(),
                        ],
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Text(user.first_name + ' ' + user.last_name),
                  subtitle: Text(user.username),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(user.email),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  title: Text('Адресс'),
                  subtitle: Text('address'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                ListTile(
                  title: Text('Выйти'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    await kStorage.delete(key: 'authToken');
                    await AuthConfig().init();
                    setState(() {});
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Scaffold buildLogin() {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Вы не вошли в свой аккаунт',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              label: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
