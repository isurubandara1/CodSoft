import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class BudgetScreen extends StatefulWidget {
  static const routeName = '/budget';

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _budgetController = TextEditingController();

  void _submitBudget() {
    final enteredBudget = double.parse(_budgetController.text);

    if (enteredBudget <= 0) {
      return;
    }

    Provider.of<TransactionProvider>(context, listen: false)
        .setMonthlyBudget(enteredBudget);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Monthly Budget'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _budgetController,
              decoration: InputDecoration(labelText: 'Monthly Budget'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _submitBudget,
              child: Text('Set Budget'),
            ),
          ],
        ),
      ),
    );
  }
}
