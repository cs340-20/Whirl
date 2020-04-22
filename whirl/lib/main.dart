import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        home: SplashPage(),
        routes: {
          '/LoginPage': (BuildContext context) => LoginPage(),
          '/HomePage': (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.teal,
            fontFamily: 'Montserrat',
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
                    color: Colors.teal, fontSize: 20.0)))
    );

  }
}

class SplashPage extends StatefulWidget {
  @override
  State createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((value) {
      user = value;
      if (user != null) {
        print("Silently Signed in");
        Navigator.popAndPushNamed(context, '/HomePage');
      } else Navigator.popAndPushNamed(context, '/LoginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Image(image: AssetImage("assets/Logo1024.png")),
        Text('Whirl', style: TextStyle(fontSize: 48, color: Colors.white))
      ]),
    ));
  }
}
