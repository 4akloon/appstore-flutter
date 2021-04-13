import 'package:flutter/material.dart';

class UserModel {
  final String email, username, first_name, last_name;

  UserModel({
    @required this.username,
    @required this.email,
    @required this.first_name,
    @required this.last_name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      username: json['username'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }
}
