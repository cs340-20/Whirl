import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whirl/rideCard.dart';

class RidesPage extends StatefulWidget {
  @override
  State createState() => new RidesPageState();
}

class RidesPageState extends State<RidesPage> {
  List list;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(25), child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      Center(child: Padding(padding: EdgeInsets.all((15)), child: Text('Avaliable Rides', style: TextStyle(fontSize: 24)))),
      Expanded(child: FutureBuilder<FirebaseUser>(future: FirebaseAuth.instance.currentUser(), builder: (context, user) => user.hasData? StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("rides").snapshots(),
        builder: (_, snapshot) => snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length, //length of document array returned from future -TM
            itemBuilder: (_, index) =>
                RideCard(document: snapshot.data.documents[index], trailing: snapshot.data.documents[index].data['assigned'].contains(user.data.uid)? null : IconButton(icon: Icon(Icons.add),
                    onPressed: () {
                      List assignees = snapshot.data.documents[index].data['assigned'];
                      assignees.add(user.data.uid);
                      snapshot.data.documents[index].reference.setData({"assigned": assignees}, merge: true);
                    }))
        ) : Center (
          child: CircularProgressIndicator(),
        )
    ) : Container()))]));
  }
}
