import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_screen.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  const Home({Key key, this.user, this.googleSignIn}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-I Manager'),
        centerTitle: true,
        elevation: 3.0,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(widget.user.email),
              accountName: Text(widget.user.displayName),
            ),
            ListTile(
              title: Text('Log Out'),
              trailing: IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: (){
                  setState(() {
                    widget.googleSignIn.signOut();
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context)=> LoginPage()
                  ));
                },
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Text('Hello ${ widget.user.displayName}'),
      ),
    );
  }
}
