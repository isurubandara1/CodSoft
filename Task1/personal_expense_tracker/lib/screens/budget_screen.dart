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
        backgroundColor: Colors.blue,
        title: const Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Add Your Budget',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: const Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BackButton(
            color: Colors.white,
          ),
        ),
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
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _submitBudget,
              child: Text('Set Budget'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset(
                'assets/images/Budget.png',
                height: 300,
                width: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
