import 'package:appstore/models/customer.dart';
import 'package:intl/intl.dart';

class Review {
  final int id;
  final Customer customer;
  final String text;
  final String date;

  Review({
    this.id,
    this.customer,
    this.text,
    this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['date']);
    String formattedData = DateFormat('yyyy.MM.dd HH:mm').format(dateTime);
    return Review(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      text: json['text'],
      date: formattedData,
    );
  }
}
