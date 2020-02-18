import 'package:budget_manager/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Expense{
  final String userId;
  final String category;
  final String amount;
  final String mode;
  final String dateTime;
  final String description;

  Expense(this.category, this.amount, this.mode, this.dateTime, this.description, this.userId);

}