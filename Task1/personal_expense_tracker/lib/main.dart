import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/category_screen.dart';
import 'screens/budget_screen.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TransactionProvider(),
      child: MaterialApp(
        title: 'Personal Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          AddTransactionScreen.routeName: (ctx) => AddTransactionScreen(),
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          BudgetScreen.routeName: (ctx) => BudgetScreen(),
        },
      ),
    );
  }
}
