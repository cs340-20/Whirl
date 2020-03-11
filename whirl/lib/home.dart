import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whirl/map.dart';
import 'package:whirl/messages.dart';
import 'package:whirl/notifications.dart';
import 'package:whirl/profile.dart';
import 'package:whirl/rides.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _index = 2;
  List<Widget> pages = [RidesPage(), NotificationsPage(), MapPage(), MessagesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Whirl"), automaticallyImplyLeading: false, actions: <Widget>[
        PopupMenuButton(
          onSelected: (index) {
            switch (index) {
              case 1:
                FirebaseAuth.instance.signOut().then((value) => Navigator.popAndPushNamed(context, '/LoginPage'));
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 1,
              child: Text('Log Out'),
            ),
          ],
        )
      ]),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.shifting, currentIndex: _index, onTap: (index) => setState(() => _index = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.assignment, color: _index == 0? Colors.teal.shade800 : Colors.teal.shade500, size: 40), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.notifications, color: _index == 1? Colors.teal.shade800 : Colors.teal.shade500, size: 40), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.directions_car, color: _index == 2? Colors.teal.shade800 : Colors.teal.shade500, size: 40), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.message, color: _index == 3? Colors.teal.shade800 : Colors.teal.shade500, size: 40), title: Text("")),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: _index == 4? Colors.teal.shade800 : Colors.teal.shade500, size: 40), title: Text("")),
          ]),
    );
  }
}
