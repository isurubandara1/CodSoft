import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_list.dart';
import 'add_transaction_screen.dart';
import 'category_screen.dart';
import 'budget_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    // Calculate remaining budget
    double remainingBudget =
        transactionProvider.monthlyBudget - transactionProvider.totalExpenses;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Personal Expense \nTracker',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(
                  Icons.category,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CategoryScreen.routeName);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(BudgetScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.amber,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
              child: Column(
                children: [
                  Text(
                    'Monthly Budget: \$${transactionProvider.monthlyBudget.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total Expenses: \$${transactionProvider.totalExpenses.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Remaining  Budget: \$${remainingBudget.toStringAsFixed(2)}', // Display remaining budget
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TransactionList(),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        child: Text(
          "Add \nTransactions",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTransactionScreen.routeName);
        },
        style: ElevatedButton.styleFrom(
          elevation: 15,
          primary: Colors.blue,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.grey, width: 2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
