import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  //I'm guessing we do pre-auth check here... -TM
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