import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State createState() => new MapPageState();
}

class MapPageState extends State<MapPage> {

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //       child: Text("Map Page"),
  //     );
  // }

  GoogleMapController mapController;

  final LatLng _center = const LatLng(35.9606, -83.9207);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
