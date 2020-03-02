import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whirl/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//list view of rides here...

class ListRoute extends StatelessWidget {
  @override
  // Widget build(BuildContext context) {
  //   return new StreamBuilder(
  //       stream: Firestore.instance.collection('Rides').document('K0vwi4gVKW2SBqgIT1xX').snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return new Text("Loading");
  //         }
  //         var userDocument = snapshot.data;
  //         return new Text(userDocument["DestAsString"]);
  //       }
  //   );
  // }
    Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('K0vwi4gVKW2SBqgIT1xX').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['DestAsString']),
                  subtitle: new Text(document['DestAsString']),
                );
              }).toList(),
            );
        }
      },
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('List Route'),
  //     ),
  //     body: Center(
  //       child: Text("user " + curuser.email + " signed in"),
  //     )
  //   );
  // }
}