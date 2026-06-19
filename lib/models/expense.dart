class Expense {
  final double amount;
  final String category;
  final String note;
  final String paymentMethod;
  final DateTime date;

  Expense({
    required this.amount,
    required this.category,
    required this.note,
    required this.paymentMethod,
    required this.date,
  });
}