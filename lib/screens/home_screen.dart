import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_expense_screen.dart';
import '../providers/expense_provider.dart';
import 'expense_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SpendWise AI",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text("Total Spending", style: TextStyle(fontSize: 18)),

                    SizedBox(height: 10),

                    Consumer<ExpenseProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          "₹${provider.totalExpense.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Recent Expenses",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: Consumer<ExpenseProvider>(
                builder: (context, provider, child) {
                  if (provider.expenses.isEmpty) {
                    return Center(
                      child: Text(
                        "No expenses added yet.",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.expenses.length,

                    itemBuilder: (context, index) {
                      final expense = provider.expenses[index];

                      return Dismissible(
                        key: ValueKey(expense),

                        direction: DismissDirection.endToStart,

                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),

                        onDismissed: (_) {
                          final deletedExpense = expense;
                          final deletedIndex = index;

                          provider.deleteExpense(index);

                          ScaffoldMessenger.of(context).clearSnackBars();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("Expense deleted"),
                              duration: const Duration(seconds: 4),

                              action: SnackBarAction(
                                label: "UNDO",

                                onPressed: () {
                                  provider.restoreExpense(
                                    deletedIndex,
                                    deletedExpense,
                                  );
                                },
                              ),
                            ),
                          );
                        },

                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ExpenseDetailsScreen(
                                    expense: expense,
                                    expenseIndex: index,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              child: Text(expense.category[0]),
                            ),

                            title: Text(
                              expense.note.isEmpty
                                  ? expense.category
                                  : expense.note,
                            ),

                            subtitle: Text(
                              "${expense.category} • ${expense.paymentMethod}",
                            ),

                            trailing: Text(
                              "₹${expense.amount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );
        },

        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),

          NavigationDestination(
            icon: Icon(Icons.analytics),
            label: "Analytics",
          ),

          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
