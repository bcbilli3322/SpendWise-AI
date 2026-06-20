import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailsScreen({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
    DateFormat('dd MMM yyyy • h:mm a').format(expense.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Details"),
      ),

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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "₹${expense.amount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Category",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(expense.category),

                const SizedBox(height: 20),

                const Text(
                  "Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(expense.paymentMethod),

                const SizedBox(height: 20),

                const Text(
                  "Note",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  expense.note.isEmpty
                      ? "No note"
                      : expense.note,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(formattedDate),
              ],
            ),
          ),
        ),
      ),
    );
  }
}