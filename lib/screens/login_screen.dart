import 'package:budget_manager/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login.png"),
              fit: BoxFit.cover
            )
          ),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: Center(
                          child: Text("E-I Manager",style:TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                          hintStyle: TextStyle(color:Colors.white),
                          labelStyle: TextStyle(color:Colors.white),
                          icon: Icon(Icons.email,color: Colors.white,),
                          filled: true
                        ),
                        onSaved: (value){
                          setState(() {
                            _email = value;
                          });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          filled: true,
                          hintStyle: TextStyle(color:Colors.white),
                          labelStyle: TextStyle(color:Colors.white),
                          icon: Icon(Icons.lock_open,color: Colors.white,),
                        ),
                        obscureText: true,
                        onSaved: (value){
                          setState(() {
                            _password = value;
                          });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0,),
                      FlatButton(
                        child: Text('LOGIN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                        color: Colors.amber,
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();

                          }else{

                          }
                        },
                      ),
                      SizedBox(height: 12.0,),
                      Center(
                        child: Text('Or',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 12.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Google',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            color: Colors.transparent,
                            onPressed: (){

                            },
                          ),
                          RaisedButton(
                            child: Text('Facebook',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            color: Colors.transparent,
                            onPressed: (){

                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0,),
                      Divider(height: 10.0,),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('forgot password?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Divider(height: 10.0,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(
                              builder: (BuildContext context) => RegisterScreen()
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Divider(height: 10.0,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
