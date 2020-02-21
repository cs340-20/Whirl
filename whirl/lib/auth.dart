import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

String email, password;

//save email and password from form...

// final GoogleSignIn _googleSignIn = GoogleSignIn();
// final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseAuth auth = FirebaseAuth.instance;


Future < FirebaseUser > signIn(String email, String password) async {    
    try {    
        final FirebaseUser user = (await auth.signInWithEmailAndPassword(email: email, password: password)).user;
        
        assert(user != null);    
        assert(await user.getIdToken() != null);    
        final FirebaseUser currentUser = await auth.currentUser();    
        assert(user.uid == currentUser.uid);    
        return user;    
    } catch (e) {    
        // handleError(e);    
        return null;    
    }    
}  

Future < FirebaseUser > signUp(email, password) async {  
    try {  
        FirebaseUser user = (await auth.createUserWithEmailAndPassword(email: email, password: password)).user;  
        assert(user != null);  
        assert(await user.getIdToken() != null);  
        return user;  
    } catch (e) {  
        // handleError(e);  
        return null;  
    }  
}   

// Future<FirebaseUser> _handleSignIn() async {
//   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
//   print("signed in " + user.displayName);
//   return user;
// }