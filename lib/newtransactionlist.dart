import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  final Function addTx;

  newTransaction(this.addTx);

  @override
  _newTransactionState createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submit() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  keyboardType: TextInputType.name,
                  onSubmitted: (_) => submit(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submit(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen !'
                            : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
                      ),
                      FlatButton(
                          onPressed: _showDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ))
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: submit,
                  child: Text('Add Transaction'),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                )
              ],
            )),
      ),
    );
  }
}
