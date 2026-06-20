import 'package:flutter/material.dart';
import '../utils/date_formatter.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;
  final int expenseIndex;

  const ExpenseDetailsScreen({
    super.key,
    required this.expense,
    required this.expenseIndex,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = AppDateFormatter.formatExpenseDate(expense.date);
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Details")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  "Amount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  "₹${expense.amount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(expense.category),

                const SizedBox(height: 20),

                const Text(
                  "Payment Method",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(expense.paymentMethod),

                const SizedBox(height: 20),

                const Text(
                  "Note",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(expense.note.isEmpty ? "No note" : expense.note),

                const SizedBox(height: 20),

                const Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(formattedDate),
                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.edit),

                    label: const Text("Edit Expense"),

                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddExpenseScreen(
                            expense: expense,
                            expenseIndex: expenseIndex,
                          ),
                        ),
                      ); // Next step
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
