import 'package:firebase_auth/firebase_auth.dart';

//global
FirebaseUser curuser;

FirebaseAuth auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignIn(email, password) async {
  final FirebaseUser user =
      (await auth.signInWithEmailAndPassword(email: email, password: password))
          .user;
  print("signed in " + user.email);
  curuser = user; //idk how exception handling works below so I did this here - TM
  return user;
}

//Usage Example:
//onPressed: loginWithEmail("tmiles7@vols.utk.edu", "whirl123")
//-TM
loginWithEmail(email, password) {
    handleSignIn(email, password)
      .then((FirebaseUser user) => print(user.email))
      .catchError((e) => print(e));
}

//Usage Example:
//signUp("tuckermiles70@gmail.com", "whirl123");
//-TM
Future<FirebaseUser> signUp(email, password) async {
  final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  )).user;
  curuser = user;
  return user;
}
