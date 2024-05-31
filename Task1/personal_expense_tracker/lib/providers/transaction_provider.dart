import 'package:flutter/foundation.dart' as foundation;
import '../models/transaction.dart';

class TransactionProvider with foundation.ChangeNotifier {
  List<Transaction> _transactions = [];
  double _monthlyBudget = 0.0;

  List<Transaction> get transactions => _transactions;
  double get monthlyBudget => _monthlyBudget;

  void addTransaction(
      String title, double amount, DateTime date, Category category) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    _transactions.add(newTransaction);
    notifyListeners();
  }

  void setMonthlyBudget(double budget) {
    _monthlyBudget = budget;
    notifyListeners();
  }

  double get totalExpenses {
    return _transactions.fold(0.0, (sum, item) => sum + item.amount);
  }

  List<Transaction> getTransactionsByCategory(Category category) {
    return _transactions.where((tx) => tx.category == category).toList();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
