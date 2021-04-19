import 'package:appstore/models/user.dart';

class Customer {
  final int id;
  final UserModel user;
  final String address;
  final number;

  Customer({
    this.id,
    this.user,
    this.address,
    this.number,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      address: json['address'],
      number: json['number'],
    );
  }
}
