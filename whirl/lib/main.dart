import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whirl/home.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],
        home: LoginPage(),
        routes: {
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/HomePage': (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.teal,
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
                    color: Colors.teal, fontSize: 20.0)))
    );

  }
}