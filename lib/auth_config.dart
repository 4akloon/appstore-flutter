import 'package:appstore/constants.dart';

import 'models/user_model.dart';

class AuthConfig {
  static String token;
  static UserModel user;
  static bool isAuthorize;

  Future<void> init() async {
    if (await kStorage.containsKey(key: 'authToken')) {
      token = await kStorage.read(key: 'authToken');
      isAuthorize = true;
    } else {
      isAuthorize = false;
    }
  }

  void setUser(UserModel userModel) {
    user = userModel;
  }
}
