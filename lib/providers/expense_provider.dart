import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {

  final List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  double get totalExpense {

    double total = 0;

    for (final expense in _expenses) {
      total += expense.amount;
    }

    return total;
  }

  void addExpense(Expense expense) {

    _expenses.insert(0, expense);

    notifyListeners();
  }

  void deleteExpense(int index) {

    _expenses.removeAt(index);

    notifyListeners();
  }

  void restoreExpense(int index, Expense expense) {
    _expenses.insert(index, expense);
    notifyListeners();
  }

}