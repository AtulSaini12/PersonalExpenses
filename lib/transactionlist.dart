import 'dart:ui';

import 'package:PersonalExpenses/transaction.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: (transactions.isEmpty)
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Text(
                        'No Transactions Added Yet!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transactions[index].title}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(DateFormat()
                          .add_yMMMd()
                          .format(transactions[index].date)),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () => deleteTx(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
