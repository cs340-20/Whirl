import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whirl/newRide.dart';

class RideCard extends StatefulWidget {
  final DocumentSnapshot document;
  final Widget trailing;

  const RideCard({Key key, this.document, this.trailing}) : super(key: key);

  @override
  State createState() => new RideCardState();
}

class RideCardState extends State<RideCard> {

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      trailing: widget.trailing,
      title: Text("${widget.document.data["originAddress"]} to ${widget.document.data["destinationAddress"]}",
          style: TextStyle(fontSize: 18)),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text('${widget.document.data["passengers"]} passengers'),
        Text('leaving on ${dateFormat.format(widget.document.data["departureTime"].toDate())}')
      ]),
    ));
  }
}
