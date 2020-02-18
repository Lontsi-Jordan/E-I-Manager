import 'package:budget_manager/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  User _user;

  //signIn with Google and return a type user
  Future<User> signInWithGoogle() async{
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
    _user = userFromFirebase(user);
    return _user;
  }

  //SignIn with Email and Password and return a type user
  Future<User> signInWithEmailAndPassword(String email,String password)async{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _user = userFromFirebase(result.user);
    return _user;
  }
   //transform user firebase to custom user
  User userFromFirebase(FirebaseUser user){
    return user!=null?User(displayName: user.displayName,email: user.email,photoUrl: user.photoUrl,uid: user.uid):null;
  }

  //Register new user with email and password
  Future<User> createAccount(String email,String password) async{
    AuthResult result = await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    _user = userFromFirebase(result.user);
    return _user;
  }
  
  //get state of user
  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => userFromFirebase(user));
  }

  //signout
  Future signOut() async{
    await  _auth.signOut();
  }
}