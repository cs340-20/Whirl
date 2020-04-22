import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whirl/login.dart';
import 'package:whirl/newRide.dart';
import 'package:whirl/rideCard.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    FutureBuilder<FirebaseUser>(future: FirebaseAuth.instance.currentUser(), builder: (context, user) => user.hasData?
                    StreamBuilder<DocumentSnapshot>(stream: Firestore.instance.collection('users').document(user.data.uid).snapshots(),
                        builder: (context, stream) => Text(
                          stream.data['rides'].toString(),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18
                          ),
                        )
                    ) : Container()),
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
                    FutureBuilder<int>(future: getRating(), builder: (context, snapshot) => snapshot.hasData?
                    Row(children: List.generate(5, (rating) => Icon(rating < snapshot.data ? Icons.star : Icons.star_border, size: 15)))
                        : Container()),
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
          Divider(),
          Padding(padding: EdgeInsets.only(top: 15, bottom: 5), child: Text('Your Rides', style: TextStyle(fontSize: 24))),
          Expanded(child: StreamBuilder<QuerySnapshot>(stream: Firestore.instance.collection('rides').where("assigned", arrayContains: user.uid).snapshots(),
              builder: (context, stream) => ListView(
                  children: stream.hasData? List.generate(stream.data.documents.length,
                          (index) => RideCard(document: stream.data.documents[index], trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        IconButton(icon: Icon(Icons.check), onPressed: () {
                          Firestore.instance.collection('rides').document(stream.data.documents[index].documentID).delete();
                          setState(() {
                            FirebaseAuth.instance.currentUser().then((user) => Firestore.instance.collection('users').document(user.uid).get().then(
                                    (document) => Firestore.instance.collection('users').document(user.uid).setData({'rides': document.data['rides']+1}, merge: true)));
                          });
                        }),
                        IconButton(icon: Icon(Icons.close), onPressed: () => Firestore.instance.collection('rides').document(stream.data.documents[index].documentID).delete())
                      ]))) : List())
          ))
        ]
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

  Future<Stream<DocumentSnapshot>> getUserDoc() async {
    var user = await FirebaseAuth.instance.currentUser();
    return Firestore.instance.collection('users').document(user.uid).snapshots();
  }

  Future<String> getName() async {
    var user = await FirebaseAuth.instance.currentUser();
    var doc = await Firestore.instance.collection('users').document(user.uid).get();
    return doc.data['name'];
  }

  Future<int> getRating() async {
    var user = await FirebaseAuth.instance.currentUser();
    var doc = await Firestore.instance.collection('users').document(user.uid).get();
    return doc.data['rating'];
  }

  Future<String> getLocation() async {
    var user = await FirebaseAuth.instance.currentUser();
    var doc = await Firestore.instance.collection('users').document(user.uid).get();
    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(doc.data['location'].latitude, doc.data['location'].longitude));
    return "${addresses.first.locality}, ${addresses.first.adminArea}";
  }
}
