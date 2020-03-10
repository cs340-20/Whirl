import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],
      home: LoginPage(),
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(
                  color: Colors.teal, fontSize: 20.0)))
    );

  }
}