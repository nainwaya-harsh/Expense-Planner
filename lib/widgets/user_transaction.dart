import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'new_transaction.dart';
import 'package:intl/intl.dart';

class UserTransaction extends StatefulWidget {
  UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // NewTransaction(_addNewTransaction),
        // TransactionList(_userTransaction)
      ],
    );
  }
}
