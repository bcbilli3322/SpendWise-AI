import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense.dart';

class ExpenseStorageService {
  static const String expenseBoxName = "expenses";

  late Box<Expense> _expenseBox;

  /// Opens the Hive box.
  Future<void> init() async {
    _expenseBox = await Hive.openBox<Expense>(expenseBoxName);
  }

  /// Saves all expenses.
  Future<void> saveExpenses(List<Expense> expenses) async {
    await _expenseBox.clear();
    await _expenseBox.addAll(expenses);
  }

  /// Loads all expenses.
  Future<List<Expense>> loadExpenses() async {
    return _expenseBox.values.toList();
  }

  /// Clears all stored expenses.
  Future<void> clearAll() async {
    await _expenseBox.clear();
  }
}