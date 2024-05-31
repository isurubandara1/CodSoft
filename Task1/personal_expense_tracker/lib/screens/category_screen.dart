import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';
import '../widgets/transaction_list.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category _selectedCategory = Category.Food;

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions =
        transactionProvider.getTransactionsByCategory(_selectedCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions by Category'),
      ),
      body: Column(
        children: [
          DropdownButton<Category>(
            value: _selectedCategory,
            onChanged: (Category? newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: Category.values.map((Category category) {
              return DropdownMenuItem<Category>(
                value: category,
                child: Text(category.toString().split('.').last),
              );
            }).toList(),
          ),
          Expanded(
            child: TransactionList(transactions: transactions),
          ),
        ],
      ),
    );
  }
}
