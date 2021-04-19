import 'package:appstore/constants.dart';
import 'package:appstore/screens/pages.dart';
import 'package:appstore/services/api_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getInfoMe(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print('error');
              Future.delayed(Duration.zero, () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PagesScreen()),
                    (route) => false);
              });
              return SvgPicture.asset(
                'assets/apple.svg',
                color: Colors.white,
                width: 128,
                height: 128,
              );
            }
            if (snapshot.hasData) {
              print(snapshot.data);
              Future.delayed(Duration.zero, () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PagesScreen()),
                    (route) => false);
              });
              return SvgPicture.asset(
                'assets/apple.svg',
                color: Colors.white,
                width: 128,
                height: 128,
              );
            } else {
              return SvgPicture.asset(
                'assets/apple.svg',
                color: Colors.white,
                width: 128,
                height: 128,
              );
            }
          },
        ),
      ),
    );
  }
}
