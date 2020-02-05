import 'package:budget_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/*class MyApp extends StatelessWidget {
  Future<bool> isSignedIn() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser != null;
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
      home: isSignedIn ==null?LoginPage():Home(),
    );
  }
}*/
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: LoginPage(),
    );
  }
}


