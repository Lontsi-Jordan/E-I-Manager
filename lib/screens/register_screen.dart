import 'package:budget_manager/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  String _firstName;
  String _lastName;
  String _email;
  String _password;

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
                  width: MediaQuery.of(context).size.width*0.85,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: Center(
                          child: Text("Register",style:TextStyle(
                            fontSize: 40,
                            fontFamily: 'Billabong',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 1
                          ),),
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'First Name',
                            hintStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                            labelStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                            icon: Icon(Icons.person,color: Colors.white,),
                            filled: true
                        ),
                        onSaved: (value){
                          setState(() {
                            _firstName = value;
                          });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "First Name is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          labelText: 'Last Name',
                          hintStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          labelStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          filled: true,
                          icon: Icon(Icons.person,color: Colors.white,),
                        ),
                        onSaved: (value){
                          setState(() {
                            _lastName = value;
                          });
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return "Last Name is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          hintStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          labelStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          filled: true,
                          icon: Icon(Icons.email,color: Colors.white,),
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                          hintStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          labelStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          filled: true,
                          icon: Icon(Icons.lock_open,color: Colors.white,),
                          helperText: 'Min length 8 caracters*',
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
                          }else if(value.length < 8){
                            return 'Min length 8 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.0,),
                      GestureDetector(
                        onTap: ()async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _createAccount(_email, _password);

                          } else {

                          }
                        },
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Text('REGISTER',style: TextStyle(letterSpacing: 0.5,fontWeight: FontWeight.bold,color: Colors.white,)),
                        ),
                      ),
                      SizedBox(height: 12.0,),
                      Divider(color: Colors.grey.shade50,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Login',style: TextStyle(letterSpacing: 0.5,fontWeight: FontWeight.bold,color: Colors.white,),),
                        ),
                      ),
                      Divider(color: Colors.grey.shade50,),
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

  Future _createAccount(String email,String password) async{
    FirebaseUser user = await  _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((newUser){
          Toast.show("Account created", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
        })
        .catchError((e)=> Toast.show("This email is already use", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.BOTTOM,duration: 3));
  }
}
