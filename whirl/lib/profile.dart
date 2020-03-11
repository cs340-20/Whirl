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

final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
final List<int> colorCodes = <int>[100, 200, 300, 400, 500, 600, 700];

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
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
          // Row(
          //   children: <Widget>[
          //     Text('User\'s ride list will go here'),
          //   ],
          // ),
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 160,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.teal[colorCodes[index]],
                        child: Center(child: Text('Ride ${entries[index]}')),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )
        ],
      ),
    );
  }
}
