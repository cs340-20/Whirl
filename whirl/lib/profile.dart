import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  State createState() => new ProfilePageState();
}

final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
final List<int> colorCodes = <int>[100, 200, 300, 400, 500, 600, 700];

class ProfilePageState extends State<ProfilePage> {
  ImageProvider profileImg = AssetImage("assets/DefaultAvatar.jpg");


  @override
  void initState() {
    super.initState();
    getImage().then((img) => setState(() => profileImg = img.image));
  }

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
                child: GestureDetector(
                    onTap: () => setImage().then((file) => setState(() => profileImg = Image.file(file).image)),
                    child: CircleAvatar(backgroundImage: profileImg, radius: 50, backgroundColor: Colors.transparent)
                ),
              ),
              SizedBox(height: 25.0),
              FutureBuilder<String>(future: getName(), builder: (context, snapshot) => snapshot.hasData? Text(
                snapshot.data,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ) : Container()),
              SizedBox(height: 4.0),
              FutureBuilder<String>(future: getLocation(), builder: (context, snapshot) => snapshot.hasData? Text(
                snapshot.data,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.grey
                ),
              ) : Container()),
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
                        FutureBuilder<String>(future: getRating(), builder: (context, snapshot) => snapshot.hasData? Text(
                          snapshot.data,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ) : Container()),
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

  Future<File> setImage() async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    var croppedImg = await ImageCropper.cropImage(sourcePath: img.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    var user = await FirebaseAuth.instance.currentUser();
    FirebaseStorage.instance.ref().child(user.uid).putFile(croppedImg).onComplete;
    return croppedImg;
  }

  Future<Image> getImage() async {
    var user = await FirebaseAuth.instance.currentUser();
    var img = await FirebaseStorage.instance.ref().child(user.uid).getDownloadURL(); //50mb max
    return Image.network(img);
  }

  Future<String> getName() async {
    var user = await FirebaseAuth.instance.currentUser();
    var doc = await Firestore.instance.collection('users').document(user.uid).get();
    return doc.data['name'];
  }

  Future<String> getRating() async {
    var user = await FirebaseAuth.instance.currentUser();
    var doc = await Firestore.instance.collection('users').document(user.uid).get();
    return doc.data['rating'].toString();
  }

  Future<String> getLocation() async {
    var user = await FirebaseAuth.instance.currentUser();
    var doc = await Firestore.instance.collection('users').document(user.uid).get();
    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(doc.data['location'].latitude, doc.data['location'].longitude));
    return "${addresses.first.locality}, ${addresses.first.adminArea}";
  }
}
