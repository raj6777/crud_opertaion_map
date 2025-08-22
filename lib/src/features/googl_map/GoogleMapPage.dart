
import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late bool isDark;


  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _indiaLatLng = LatLng(20.5937, 78.9629);
/*  @override
  void initState() {
    super.initState();
    isDark = Helper.isDarkTheme(); // Initialize here
  }*/
  final Set<Marker> _markers = {
     Marker(
      markerId: MarkerId('india_marker'),
      position: _indiaLatLng,
      infoWindow: InfoWindow(title: 'India'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _indiaLatLng,
    zoom: 5.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // in the below line, we are specifying our app bar.
        appBar: AppBar(
          // setting background color for app bar
          backgroundColor: Color(0xFF0F9D58),
          // setting title for app bar.
          title: Text("Google Maps"),
        ),
        body: Container(
          // in the below line, creating google maps.
          child: GoogleMap(
            // in the below line, setting camera position
            initialCameraPosition: _initialCameraPosition,
            // in the below line, specifying map type.
            markers: _markers,
            mapType: MapType.normal,
            // in the below line, setting user location enabled.
            myLocationEnabled: true,
            // in the below line, setting compass enabled.
            compassEnabled: true,
            // in the below line, specifying controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        )
    );
  }
}

