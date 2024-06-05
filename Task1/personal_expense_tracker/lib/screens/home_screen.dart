import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_list.dart';
import '../widgets/drawer_widget.dart';
import 'add_transaction_screen.dart';
import 'category_screen.dart';
import 'budget_screen.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Calculate remaining budget
    double remainingBudget =
        transactionProvider.monthlyBudget - transactionProvider.totalExpenses;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
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
                  themeProvider.themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
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
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TransactionList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text(
                    "Add \nMonthly Budget",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(BudgetScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  child: Text(
                    "Add \nTransactions",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: transactionProvider.monthlyBudget == 0.0
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Firstly enter Monthly Budget'),
                            ),
                          );
                        }
                      : () {
                          Navigator.of(context)
                              .pushNamed(AddTransactionScreen.routeName);
                        },
                  style: ElevatedButton.styleFrom(
                    primary: transactionProvider.monthlyBudget == 0.0
                        ? Colors.grey
                        : Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
