import 'package:budget_manager/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

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
                      GestureDetector(
                        onTap: (){
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            _signInWithEmailAndPassword(_email, _password);
                          }else{

                          }
                        },
                        child: Container(
                          height: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.amber,
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
                              _handleSignIn()
                                  .then((FirebaseUser user){
                                Toast.show("Authenticate success", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (BuildContext context)=> Home(user: user,googleSignIn: _googleSignIn,)));
                              }
                              )
                                  .catchError((e){
                                    print(e);
                                    Toast.show("Authenticate failed", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.BOTTOM,duration: 3);
                                  }
                              );
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

  Future<FirebaseUser> _handleSignIn() async{
    //get google account
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    //authenticate user use google account
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    // get credentials of user
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  _signInWithEmailAndPassword(String email,String password){
    _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((newUser){
          Toast.show("Authenticate success", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context)=> Home(user: newUser.user,)));
        })
        .catchError((e){
          Toast.show("There is no user record corresponding to this identifier", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.BOTTOM,duration: 3);
        });
  }

}
