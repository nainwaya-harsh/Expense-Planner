import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/charts.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:expense_planner/widgets/user_transaction.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

void main() {
  //Setting only portrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String name;
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: '101', title: 'new shoes', price: 56.32, date: DateTime.now()),
    // Transaction(
    //     id: '102', title: 'new books', price: 85.32, date: DateTime.now()),
  ];

  bool _switch = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        price: txAmount,
        date: chosenDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: (() {}),
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  // Taking valid transaction from usertransaction and adding it to _recent transactios and passing it to the chart.dart
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Expense Planner'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                  value: _switch,
                  onChanged: (val) {
                    setState(() {
                      _switch = val;
                    });
                  },
                )
              ],
            ),
          
            _switch
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                    child: Chart(_recentTransaction))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    child:
                        TransactionList(_userTransaction, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
