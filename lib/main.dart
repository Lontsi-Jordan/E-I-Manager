import 'package:budget_manager/models/user.dart';
import 'package:budget_manager/screens/wrapper.dart';
import 'package:budget_manager/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'E-I Manager',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              accentColor: Color(0xFFFEF9EB),
              brightness: Brightness.light,
              textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Open Sans',
              ),
          ),
          home: Wrapper(),
        ),
    );
  }
}


