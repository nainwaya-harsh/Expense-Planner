import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'user_transaction.dart';

class TransactionList extends StatelessWidget {
  late final List<Transaction> transaction;
  final deleteTx;
  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(),
                Image.asset(
                  'assets/images/logo1.jpg',
                  height: constraints.maxHeight * 0.8,
                  fit: BoxFit.contain,
                ),
                Text(
                  "Kindly add items in the list",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Made With ❤️ By Harsh Nainwaya")
              ],
            );
          })
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return Card(
                color: Theme.of(context).cardColor,
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$${transaction[index].price}')),
                    ),
                  ),
                  title: Text('${transaction[index].title}'),
                  subtitle:
                      Text(DateFormat.yMMMMd().format(transaction[index].date)),
                  trailing: IconButton(
                      onPressed: (() => deleteTx(transaction[index].id)),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      )),
                ),
              );
            },
          );
  }
}
