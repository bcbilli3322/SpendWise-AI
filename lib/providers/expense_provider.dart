import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_storage_service.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [];
  final ExpenseStorageService _storageService = ExpenseStorageService();

  ExpenseProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _storageService.init();
    _expenses.addAll(await _storageService.loadExpenses());
    notifyListeners();
  }

  List<Expense> get expenses => _expenses;

  double get totalExpense {
    double total = 0;

    for (final expense in _expenses) {
      total += expense.amount;
    }

    return total;
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.insert(0, expense);
    await _storageService.saveExpenses(_expenses);
    notifyListeners();
  }

  Future<void> deleteExpense(int index) async {
    _expenses.removeAt(index);
    await _storageService.saveExpenses(_expenses);
    notifyListeners();
  }

  Future<void> restoreExpense(int index, Expense expense) async {
    _expenses.insert(index, expense);
    await _storageService.saveExpenses(_expenses);
    notifyListeners();
  }

  Future<void> updateExpense(int index, Expense updatedExpense) async {
    _expenses[index] = updatedExpense;
    await _storageService.saveExpenses(_expenses);
    notifyListeners();
  }
}
