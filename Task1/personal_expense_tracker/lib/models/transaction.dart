import 'package:flutter/foundation.dart';

enum Category { Food, Entertainment, Transport, Shopping, Others }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}
