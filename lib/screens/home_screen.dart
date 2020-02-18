import 'package:budget_manager/models/user.dart';
import 'package:budget_manager/screens/transactions..dart';
import 'package:budget_manager/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'expense_screen.dart';
import 'login_screen.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('E-I Manager',style: TextStyle(
          fontFamily: 'Billabong',
          fontWeight: FontWeight.w500, color: Colors.white,
          fontSize: 30,
          letterSpacing: 1
        ),),
        centerTitle: true,
        elevation: 3.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(widget.user.email,style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 0.5
              ),),
              accountName: Text(widget.user.displayName,style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 0.5
              ),),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(widget.user.photoUrl),
                backgroundColor: Colors.transparent,
              )
            ),
            ListTile(
              title: Text('Log Out',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400
              ),),
              trailing: IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () async{
                  await authService.signOut();
                  Toast.show("Log out success", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 5);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context)=> LoginPage()
                  ));
                },
              ),
            )
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Container(
            height: 30,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Texts('Income',Colors.red),
                                Texts("\$${ 500 }",Colors.red)
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Texts('Expense',Colors.blue),
                                Texts("\$${ 500 }",Colors.blue)
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Texts('Balance',Colors.green),
                                Texts('\$${ 500 }',Colors.green)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context)=>ExpenseScreen()
                                ));
                              },
                              child: Card(
                                elevation: 2.0,
                                color: Colors.blue.shade200,
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: Colors.blue.shade600
                                    ),
                                    child: Icon(Icons.monetization_on,size: 50,color: Colors.white,),
                                  ),
                                  title: Texts('ADD EXPENSE',Colors.blue),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2.0,
                              color: Colors.blue.shade100,
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.blue.shade500
                                  ),
                                  child: Icon(Icons.monetization_on,size: 50,color: Colors.white,),
                                ),
                                title: Texts('ADD INCOME',Colors.blue),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context)=>Transactions()
                                ));
                              },
                              child: Card(
                                  elevation: 2.0,
                                  color: Colors.deepOrange.shade200,
                                  child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: Colors.deepOrange.shade600
                                      ),
                                      child: Icon(Icons.library_books,size: 50,color: Colors.white,),
                                    ),
                                    title: Texts('ALL TRANSACTIONS',Colors.deepOrange),
                                  ),
                                ),
                            ),
                            Card(
                              elevation: 2.0,
                              color: Colors.redAccent.shade100,
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.red
                                  ),
                                  child: Icon(Icons.score,size: 50,color: Colors.white,),
                                ),
                                title: Texts('REPPORT',Colors.red),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
            ),
            )
          )
        ],
      )
    );
  }
}
