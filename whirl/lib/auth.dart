import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String email, password;

//save email and password from login screen

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseAuth auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleSignIn() async {
  final FirebaseUser user = (await auth.signInWithEmailAndPassword(email: "tmiles7@vols.utk.edu", password: "whirl123")).user;
  print("signed in " + user.email);
  return user;
}

loginWithEmail() {
  _handleSignIn()
    .then((FirebaseUser user) => print(user.email))
    .catchError((e) => print(e));
}

void signUp(email, password) async{
  final FirebaseUser user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
}