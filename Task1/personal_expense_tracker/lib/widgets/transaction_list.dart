import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction>? transactions;

  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    final txs =
        transactions ?? Provider.of<TransactionProvider>(context).transactions;
    return ListView.builder(
      itemCount: txs.length,
      itemBuilder: (ctx, index) {
        final tx = txs[index];
        return Card(
          child: ListTile(
            title: Text(tx.title),
            subtitle: Text(
                '\$${tx.amount.toStringAsFixed(2)} - ${tx.category.toString().split('.').last}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat.yMMMd().format(tx.date)),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<TransactionProvider>(context, listen: false)
                        .deleteTransaction(tx.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
