import 'package:budget_manager/models/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseExpense{

  //collection reference
  CollectionReference expenseCollection = Firestore.instance.collection('expense');

  //function to add expense to cloud firestore
  Future addExpense(Expense expense) async{
    return await expenseCollection.add({
      'category':expense.category,
      'amount':expense.amount,
      'date':expense.dateTime,
      'description':expense.description,
      'userId':expense.userId,
      'mode':expense.mode
    });
  }
  //function to update expense to cloud firestore
  Future updateExpense(Expense expense,String id)async{
    return await expenseCollection.document(id).setData({
      'category':expense.category,
      'amount':expense.amount,
      'date':expense.dateTime,
      'description':expense.description,
      'userId':expense.userId,
      'mode':expense.mode
    });
  }
  //list from map
  List<Expense> listFromMap(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Expense(
          doc.data['category'],
          doc.data['amount'],
          doc.data['mode'],
          doc.data['date'],
          doc.data['description'],
          doc.data['userId']);
    });
  }
  //stream to get all expenses
  Stream<QuerySnapshot> get expenses{
    return expenseCollection.snapshots();
  }
}