import 'package:hive_flutter/hive_flutter.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final String paymentMethod;

  @HiveField(4)
  final DateTime date;

  Expense({
    required this.amount,
    required this.category,
    required this.note,
    required this.paymentMethod,
    required this.date,
  });
}