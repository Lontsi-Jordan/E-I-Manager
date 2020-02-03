import 'package:budget_manager/screens/home_screen.dart';
import 'package:budget_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<FirebaseUser> isLogged() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user !=null){
      return user;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-I Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light
      ),
      home: isLogged() ==null?LoginPage():Home(),
    );
  }
}

