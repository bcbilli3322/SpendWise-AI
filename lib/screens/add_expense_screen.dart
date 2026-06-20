import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/categories.dart';
import '../constants/payment_methods.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String selectedCategory = Categories.all.first;

  String selectedPaymentMethod = PaymentMethods.all.first;

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Add Expense"),
      ),

      body: SafeArea(

        child: Form(
          key: _formKey,

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(16),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text(
                  "Amount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
  controller: amountController,

  keyboardType: const TextInputType.numberWithOptions(
    decimal: true,
  ),

  decoration: const InputDecoration(
    hintText: "Enter amount",
    border: OutlineInputBorder(),
    prefixText: "₹ ",
  ),

  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter an amount";
    }

    final amount = double.tryParse(value);

    if (amount == null) {
      return "Please enter a valid number";
    }

    if (amount <= 0) {
      return "Amount must be greater than zero";
    }

    return null;
  },
),

                const SizedBox(height: 25),

                const Text(
                  "Category",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,

                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),

                  items: Categories.all.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),

                  onChanged: (value) {

                    setState(() {

                      selectedCategory = value!;

                    });

                  },
                ),

                const SizedBox(height: 25),

                const Text(
                  "Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                initialValue: selectedPaymentMethod,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),

                items: PaymentMethods.all.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),

                onChanged: (value) {

                  setState(() {

                    selectedPaymentMethod = value!;

                  });

                },
              ),

              const SizedBox(height: 25),

              const Text(
                "Note",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
  controller: noteController,

  decoration: const InputDecoration(
    hintText: "Optional note",
    border: OutlineInputBorder(),
  ),

  maxLines: 2,

  textCapitalization: TextCapitalization.sentences,
),

              const SizedBox(height: 25),

              const Text(
                "Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,

                child: OutlinedButton.icon(

                  icon: const Icon(Icons.calendar_month),

                  label: Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  ),

                  onPressed: () async {

                    final picked = await showDatePicker(

                      context: context,

                      initialDate: selectedDate,

                      firstDate: DateTime(2020),

                      lastDate: DateTime(2100),

                    );

                    if (picked != null) {

                      setState(() {

                        selectedDate = picked;

                      });

                    }

                  },

                ),
              ),

              const SizedBox(height: 35),

                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: FilledButton(

                    onPressed: () {

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final expense = Expense(
                        amount: double.parse(amountController.text),
                        category: selectedCategory,
                        note: noteController.text.trim(),
                        paymentMethod: selectedPaymentMethod,
                        date: selectedDate,
                      );

                      context.read<ExpenseProvider>().addExpense(expense);

                      Navigator.pop(context);

                    },

                    child: const Text(

                      "Save Expense",

                      style: TextStyle(fontSize: 16),

                    ),

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