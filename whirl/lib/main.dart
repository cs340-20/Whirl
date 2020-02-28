import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:whirl/login.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new LoginPage(),
      theme: new ThemeData(
        primarySwatch: Colors.blue
      )
    );

  }
}

class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  AnimationController _iconanimationController;
  Animation<double> _iconAnimation;

  @override
  void initState(){
    super.initState();
    _iconanimationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 600)
    );
    _iconAnimation  = new CurvedAnimation(
      parent: _iconanimationController,
      curve: Curves.bounceOut
    );
    _iconAnimation.addListener(()=> this.setState(() {}));
    _iconanimationController.forward();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
      fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/Whirl-flyer.png"),
            fit: BoxFit.cover, 
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100,
              ),
              new Form(child: Theme(
                data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal, 
                  inputDecorationTheme: new InputDecorationTheme(
                    labelStyle: new TextStyle(
                      color: Colors.teal, fontSize: 20.0)
                  ) ),
                
                child: new Container(
                  padding: const EdgeInsets.all(60.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                       ),
                       new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Password",
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 40.0),
                      ),
                      new MaterialButton(
                        height: 40.0,
                        minWidth: 100.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text(
                          "Login"
                        ),
                        onPressed: ()=>{},
                        splashColor: Colors.redAccent,
                      ),
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
}
