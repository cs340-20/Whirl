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
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'assets/WhirlLogo144.png',
                child: Container (
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
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       '15K',
                    //       style: TextStyle (
                    //         fontFamily: 'Montserrat',
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     SizedBox(height: 5.0),
                    //     Text(
                    //       'FOLLS',
                    //       style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '15',
                          style: TextStyle (
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
                          style: TextStyle (
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
        ],
      ),
    );
  }
}
