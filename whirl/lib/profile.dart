import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State createState() => new ProfilePageState();
}

// class ProfilePageState extends State<ProfilePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Profile Page"),
//     );
//   }
// }

class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'assets/WhirlLogo144.png',
                child: Container (
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(62.5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/WhirlLogo144.png'),
                    )
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text (
                'Tucker Miles',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Knoxville, TN'
              ),
            ],
          )
        ],
      )
    );
  }
}
