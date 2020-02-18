import 'package:budget_manager/models/user.dart';
import 'package:budget_manager/screens/home_screen.dart';
import 'package:budget_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user !=null?Home(user: user,):LoginPage();
  }
}