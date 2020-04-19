import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State createState() => new ProfilePageState();
}

final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
final List<int> colorCodes = <int>[100, 200, 300, 400, 500, 600, 700];

class ProfilePageState extends State<ProfilePage> {

  Future getRides() async {
    //instantiate firestore instance -TM
    var firestore = Firestore.instance;
    
    QuerySnapshot qn = await firestore.collection("Rides").getDocuments();

    //essentially returns an array of the document snapshots -TM
    return qn.documents;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/Avatars/TuckerBitmoji.jpg'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'Tucker Miles',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Knoxville, TN',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
              ),
              Padding(
                // padding: EdgeInsets.all(30),
                padding: EdgeInsets.only(
                  left: 100,
                  top: 30,
                  right: 100,
                  bottom: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '15',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'TRIPS',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '10',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'RATING',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Card(
            child: ListTile(
              leading: Image(image: AssetImage("assets/Logo1024.png")),
              title: Text('Charlotte to Knoxville'),
              subtitle: Text(
                'Leaving 12:00pm on April 23'
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ), 
          Card(
            child: ListTile(
              leading: Image(image: AssetImage("assets/Logo1024.png")),
              title: Text('UT Campus to West Town Mall'),
              subtitle: Text(
                'Leaving 1:00pm on April 21'
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
              leading: Image(image: AssetImage("assets/Logo1024.png")),
              title: Text('Farragut to Maryville'),
              subtitle: Text(
                'Leaving 9:00am on April 26'
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
              leading: Image(image: AssetImage("assets/Logo1024.png")),
              title: Text('Halls to Sevierville'),
              subtitle: Text(
                'Leaving 11:00an on April 25'
              ),
              trailing: Icon(Icons.more_vert),
              isThreeLine: true,
            ),
          ),                                       
        ],
      ),
    );
  }

  Widget buildImages() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Container(
          height: 200.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: AssetImage('assets/Logo1024.png'), fit: BoxFit.cover))),
    );
  }


  
}
