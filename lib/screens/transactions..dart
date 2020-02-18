import 'package:budget_manager/models/expense.dart';
import 'package:budget_manager/screens/transactions_list.dart';
import 'package:budget_manager/services/database_expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  Widget Texts(String msg,Color color){
    return Text(msg,style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: 16
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseExpense().expenses,
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Transactions',style: TextStyle(
            fontFamily: 'Billabong',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            letterSpacing: 1
          ),),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 40.0,
                padding: EdgeInsets.all(2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Texts("Février",Colors.white),
              ),
              SizedBox(height: 10,),
              Expanded(child: TransactionList()),
            ],
          ),
        )
      ),
    );
  }
}
