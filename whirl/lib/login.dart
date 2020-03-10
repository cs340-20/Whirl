import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

FirebaseUser user;

class LoginPage extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey(debugLabel: "Form Key");
  final GlobalKey<ScaffoldState> _scaffoldKey  = GlobalKey(debugLabel: "Scaffold Key");
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  String _email, _password, _name;
  bool _loading, _newUser;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _newUser = false;

    FirebaseAuth.instance.currentUser().then((value) {
      user = value;
      if (user != null) {
        print("Silently Signed in");
        Navigator.popAndPushNamed(context, '/HomePage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: widget._scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Form(key: widget._formKey,
            child: ListView(padding: EdgeInsets.all(30),children: <Widget>[Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Image(image: AssetImage("assets/Logo1024.png")),
              _newUser? TextFormField(onChanged: (name) => _name = name,
                  validator: (name) => name.isEmpty? "Name can't be empty" : null,
                  decoration: InputDecoration(labelText: "First Name", prefixIcon: Icon(Icons.person))) : Container(),
              Padding(padding: EdgeInsets.all(10)),
              TextFormField(keyboardType: TextInputType.emailAddress, onChanged: (email) => _email = email,
                  validator: (email) {
                    if (email.isEmpty) return "Email can't be empty";
                    else if (email.split(".").last != "edu") return "Must use a university email address";
                    else return null;
                  },
                  decoration: InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email))),
              Padding(padding: EdgeInsets.all(10)),
              TextFormField(obscureText: true, keyboardType: TextInputType.visiblePassword, onChanged: (password) => _password = password,
                  validator: (password) => password.isEmpty? "Password can't be empty" : null,
                  decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.vpn_key))),
              Padding(padding: EdgeInsets.all(10)),
              _newUser? TextFormField(obscureText: true, keyboardType: TextInputType.visiblePassword,
                  validator: (passConfirmation) => passConfirmation != _password? "Passwords must match" : null,
                  decoration: InputDecoration(labelText: "Re-enter Password", prefixIcon: Icon(Icons.vpn_key))) : Container(),
              Padding(padding: EdgeInsets.all(10)),
              _loading? CircularProgressIndicator() : FlatButton(color: Theme.of(context).primaryColor,
                  onPressed: () => _newUser? _signUp() : _signIn(),
                  child: Padding(padding: EdgeInsets.all(10), child: Text(_newUser? "Sign Up" : "Login", style: TextStyle(fontSize: 18)))),
              Align(alignment: Alignment.bottomLeft, child: OutlineButton(onPressed: () => setState(() => _newUser = !_newUser), child: _newUser? Text("Already a user? Sign In!") : Text("New user? Sign Up!")))
            ]),
            ])));
  }

  void _signIn() async {
    if (!widget._formKey.currentState.validate()) return;
    setState(() => _loading = true);
    print('Sign in attempt: $_email with $_password');

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
        .catchError((error) {
      widget._scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("A user with that email and password was not found")));
    });

    user = await FirebaseAuth.instance.currentUser();
    if (user != null) Navigator.popAndPushNamed(context, '/HomePage');

    setState(() => _loading = false);
  }

  void _signUp() async {
    if (!widget._formKey.currentState.validate()) return;
    setState(() => _loading = true);
    print('Sign up attempt: $_email with $_password');

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
        .catchError((error) => print("Error creating user: $error"));

    user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      LocationData location = await Location().getLocation();
      await Firestore.instance.collection("users").document(user.uid).setData({
        "name": _name,
        "location": GeoPoint(location.latitude, location.longitude),
        "rating": 5
      });
      Navigator.popAndPushNamed(context, '/HomePage');
    } else print("No Authenticated user");

    setState(() => _loading = false);
  }
}