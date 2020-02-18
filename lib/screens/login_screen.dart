import 'package:budget_manager/partials/loading.dart';
import 'package:budget_manager/screens/register_screen.dart';
import 'package:budget_manager/services/auth.dart';
import 'package:budget_manager/models/user.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final AuthService authService = AuthService();
  String _email;
  String _password;
  bool _obscure = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
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
                          child: Text("Login",style:TextStyle(
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                          hintStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          labelStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
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
                          hintStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          labelStyle: TextStyle(color:Colors.white,letterSpacing: 0.5),
                          icon: Icon(Icons.lock_open,color: Colors.white,),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure?Icons.visibility_off:Icons.visibility,size: 20,color: Colors.white,),
                            onPressed: (){
                              setState(() {
                                if(_obscure == true){
                                  _obscure = false;
                                }else{
                                  _obscure = true;
                                }
                              });
                            }
                          ),
                        ),
                        obscureText: _obscure,
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
                      GestureDetector(
                        onTap: (){
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            setState(() {
                              loading = true;
                            });
                            authService.signInWithEmailAndPassword(_email, _password)
                            .then((User user){
                              Toast.show("Authenticate success", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
                              Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (BuildContext context)=> Home(user: user,)));
                            })
                            .catchError((e){
                              setState(() {
                                loading = false;
                              });
                              Toast.show("There is no user record corresponding to this identifier", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.BOTTOM,duration: 3);
                            });
                          }else{

                          }
                        },
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.amber.shade600,
                            borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0.5,color: Colors.white,)),
                        ),
                      ),
                      SizedBox(height: 12.0,),
                      Center(
                        child: Text('Or',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0.5,color: Colors.white,),),
                      ),
                      SizedBox(height: 12.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                loading=true;
                              });
                              authService.signInWithGoogle()
                              .then((User user){
                                Toast.show("Authenticate success", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (BuildContext context)=> Home(user: user)));
                              })
                              .catchError((e){
                                setState(() {
                                  loading = false;
                                });
                                Toast.show("Authenticate failed", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.BOTTOM,duration: 3);
                              });
                            },
                            child: Container(
                              height: 50.0,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50.0)
                              ),
                              child: Text('Google',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0.5,color: Colors.white,),),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              
                            },
                            child: Container(
                              height: 50.0,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50.0)
                              ),
                              child: Text('Facebook',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0.5,color: Colors.white,),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0,),
                      Divider(color: Colors.grey.shade50,),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('forgot password?',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0.5,color: Colors.white,),),
                      ),
                      Divider(color: Colors.grey.shade50,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(
                              builder: (BuildContext context) => RegisterScreen()
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0.5,color: Colors.white,),),
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
}
