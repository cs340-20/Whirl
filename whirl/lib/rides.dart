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

  navigateToDetail (DocumentSnapshot post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getRides(),
        builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center (
            child: CircularProgressIndicator(),
          );
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data.length, //length of document array returned from future -TM
            itemBuilder: (_, index) {
              // return ListTile(
              //   title: Text(snapshot.data[index].data["DestAsString"]),
              //   onTap: () => navigateToDetail(snapshot.data[index]),
              // );
              return ListTile(
                leading: Image(image: AssetImage("assets/Logo1024.png")),
                title: Text(snapshot.data[index].data["DestAsString"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text("Details: " + snapshot.data[index].data["Details"]),
                    Text("Contact: " + "123-456-7890"),
                  ]
                ),
                isThreeLine: true,
              );
          });
        }
      }),
    );
  }
}

class DetailPage extends StatefulWidget {

  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(widget.post.data["DestAsString"]),
          subtitle: Text(widget.post.data["Details"]),
        ),
      )
    );
  }
}
