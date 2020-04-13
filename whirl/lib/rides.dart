import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RidesPage extends StatefulWidget {
  @override
  State createState() => new RidesPageState();
}

class RidesPageState extends State<RidesPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future getRides() async {
    //instantiate firestore instance -TM
    var firestore = Firestore.instance;
    
    QuerySnapshot qn = await firestore.collection("Rides").getDocuments();

    //essentially returns an array of the document snapshots -TM
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getRides(),
        builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center (
            child: Text("Loading"), //do circprogressindic instead -TM
          );
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data.length, //length of document array returned from future -TM
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(snapshot.data[index].data["DestAsString"]),
              );
          });
        }
        // return Text("TuckeSr");
      }),
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
