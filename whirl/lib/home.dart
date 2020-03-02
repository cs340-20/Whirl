import 'package:flutter/material.dart';
import 'package:whirl/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//list view of rides here...

class ListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Route'),
      ),
      body: Center(
        child: Text("user " + curuser.email + " signed in"),
      )
    );
  }
}