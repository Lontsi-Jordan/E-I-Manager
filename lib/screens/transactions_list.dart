import 'package:budget_manager/models/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Widget Texts(String msg,Color color,){
    return Text(msg,style: TextStyle(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: 16
    ),
    );
  }
  Widget cardList(BuildContext context,index,QuerySnapshot expense){
    return Card(
      child: ExpansionTile(
        title: Texts("\$${ expense.documents[index].data['amount']}",Colors.blue),
        leading: CircleAvatar(
          child: Icon(
            Icons.monetization_on,
            size: 20,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit,size: 20,color: Colors.red,),
          onPressed: (){

          },
        ),
        subtitle: Texts("${ expense.documents[index].data['category']}",Colors.red),
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.description,size: 20,),
                Flexible(
                  child: Texts("${ expense.documents[index].data['description']}",Colors.black),
                )
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.date_range,size: 20,color: Colors.green,),
                Texts("${expense.documents[index].data['date']}",Colors.green)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expense = Provider.of<QuerySnapshot>(context);

    return ListView.builder(
      itemBuilder:(_,index){
        return cardList(context,index,expense);
      },
      itemCount: expense.documents.length,
    );
  }
}
