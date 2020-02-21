import 'package:firebase_auth/firebase_auth.dart';

//save email and password from login screen

FirebaseAuth auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleSignIn(email, password) async {
  final FirebaseUser user = (await auth.signInWithEmailAndPassword(email: email, password: password)).user;
  print("signed in " + user.email);
  return user;
}

//Usage Example: 
//onPressed: loginWithEmail("tmiles7@vols.utk.edu", "whirl123")
//-TM
loginWithEmail(email, password) {
  
  _handleSignIn(email, password)
    .then((FirebaseUser user) => print(user.email))
    .catchError((e) => print(e));
}

//Usage Example: 
//signUp("tuckermiles70@gmail.com", "whirl123");
//-TM
signUp(email, password) async {
  final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
}