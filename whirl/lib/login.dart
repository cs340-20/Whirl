import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whirl/home.dart';
import 'auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(primarySwatch: Colors.blue));
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Widget buttons;
  bool loading = false;

  AnimationController _iconanimationController;
  Animation<double> _iconAnimation;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _iconanimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 600));
    _iconAnimation = new CurvedAnimation(
        parent: _iconanimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconanimationController.forward();
    buttons = Column(children: <Widget>[
      MaterialButton(
        height: 40.0,
        minWidth: 100.0,
        // color: Colors.teal,
        color: Color(0xFF00A8E8),
        textColor: Colors.white,
        child: new Text("Login"),
        onPressed: _performLogin,
        splashColor: Colors.redAccent,
      ),
      MaterialButton(
        height: 40.0,
        minWidth: 100.0,
        // color: Colors.teal.shade800,
        color: Color(0xFF00A8E8),
        textColor: Colors.white,
        child: new Text("Don't have an account? Sign Up"),
        onPressed: () => _performSignUp(),
        splashColor: Colors.redAccent,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color(0xFF003459),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/WhirlLogo144.png"),
            alignment: Alignment(0,-0.7),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             
              new Form(
                child: Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                              // color: Colors.teal, fontSize: 20.0))),
                              color: Colors.white, fontSize: 20.0))),                        
                  child: new Container(
                    padding: const EdgeInsets.all(60.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _usernameController,
                          decoration: new InputDecoration(
                            labelText: "Enter Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        loading? CircularProgressIndicator() : buttons,
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _performSignUp() {
    String email = _usernameController.text;
    String password = _passwordController.text;

    print('Sign up attempt: $email with $password');

    signUp(email, password)
        .then((FirebaseUser user) {
          if (user != null) Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListRoute()));
        })
        .whenComplete(() => setState(() => loading = false))
        .catchError((e) => print(e));

    setState(() => loading = true);
  }

  void _performLogin() {
    String email = _usernameController.text;
    String password = _passwordController.text;

    print('login attempt: $email with $password');

    handleSignIn(email, password)
        .then((FirebaseUser user) {
          if (user != null) Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListRoute()));
        })
        .whenComplete(() => setState(() => loading = false))
        .catchError((e) => print(e));

    setState(() => loading = true);
  }
}
