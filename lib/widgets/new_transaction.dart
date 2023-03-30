import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // NewTransaction({super.key});
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();

  late DateTime _selectedDate = DateTime(0);

  void _submitData() {
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);
    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == DateTime(0)) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titlecontroller,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountcontroller,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == DateTime(0)
                      ? "No date choosen"
                      : DateFormat.yMd().format(_selectedDate)),
                ),
                TextButton(
                  onPressed: () {
                    _presentDatePicker();
                  },
                  child: Text('Choose Your Date'),
                )
              ],
            ),
          ),
          ElevatedButton(onPressed: _submitData, child: Text('Add Transaction'))
        ],
      ),
    );
  }
}
